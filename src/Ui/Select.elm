module Ui.Select exposing (Model, Msg, init, new, onSelectCallback, setOptions, setSelectedOption, update, updateWithCallbacks, view, withAdditionalWrapperStyles, withAriaLabel, withBorderRadius, withContainerPosition, withCustomOptionViewFn, withCustomSelectedOptionViewFn, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight, withPlaceholder, withTopPx)

import Css
import Css.Global
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes exposing (placeholder)
import Html.Styled.Events as Events
import Json.Decode as Decode
import List.Extra
import Ui.SelectInternal.Model as Model exposing (Model)
import Ui.SelectInternal.Msg as Msg exposing (Msg(..))
import Ui.SelectInternal.Update as Update
import Util.Accessibility as AccessibilityUtil
import Util.Icon as Icon
import Util.KeyPress as KeyPress


type alias Model a =
    Model.Model a


type alias Msg a =
    Msg.Msg a


updateWithCallbacks : List (Update.Callback a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWithCallbacks =
    Update.updateWithCallbacks


update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    Update.update


onSelectCallback : (a -> msg) -> Update.Callback a msg
onSelectCallback =
    Update.onSelectCallback


init : String -> Model a
init id =
    Model.init id


setSelectedOption : a -> Model a -> Model a
setSelectedOption option model =
    Model.setSelectedOption option model


type Select a msg
    = Settings
        { selectModel : Model a
        , optionList : List a
        , optionViewFn : Maybe (a -> Html msg)
        , optionToString : a -> String
        , selectedOptionViewFn : Maybe (a -> Html msg)
        , maybeError : Maybe String
        , maybeMaxHeight : Maybe Int
        , isRequired : Bool
        , isDisabled : Bool
        , placeholder : Maybe String
        , label : String
        , borderRadius : Float
        , topPx : Float
        , additionalWrapperStyles : List Css.Style
        , containerPosition : Css.Position {}
        , ariaLabel : Maybe String
        }


new : { label : String, selectModel : Model a, optionToString : a -> String } -> Select a msg
new { selectModel, label, optionToString } =
    let
        defaultBorderRadius =
            8

        defaultTopPx =
            58
    in
    Settings
        { selectModel = selectModel
        , maybeError = Nothing
        , maybeMaxHeight = Nothing
        , isRequired = False
        , isDisabled = False
        , optionList = []
        , placeholder = Nothing
        , label = label
        , borderRadius = defaultBorderRadius
        , optionToString = optionToString
        , topPx = defaultTopPx
        , optionViewFn = Nothing
        , selectedOptionViewFn = Nothing
        , additionalWrapperStyles = []
        , containerPosition = Css.relative
        , ariaLabel = Nothing
        }


withMenuMaxHeight : Int -> Select a msg -> Select a msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


withMaybeError : Maybe String -> Select a msg -> Select a msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


withIsRequired : Select a msg -> Select a msg
withIsRequired (Settings model) =
    Settings { model | isRequired = True }


withIsDisabled : Bool -> Select a msg -> Select a msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withBorderRadius : Float -> Select a msg -> Select a msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


withTopPx : Float -> Select a msg -> Select a msg
withTopPx topPx (Settings model) =
    Settings { model | topPx = topPx }


withCustomOptionViewFn : (a -> Html msg) -> Select a msg -> Select a msg
withCustomOptionViewFn optionViewFn (Settings model) =
    Settings { model | optionViewFn = Just optionViewFn }


withCustomSelectedOptionViewFn : (a -> Html msg) -> Select a msg -> Select a msg
withCustomSelectedOptionViewFn selectedOptionViewFn (Settings model) =
    Settings { model | selectedOptionViewFn = Just selectedOptionViewFn }


withAdditionalWrapperStyles : List Css.Style -> Select a msg -> Select a msg
withAdditionalWrapperStyles additionalWrapperStyles (Settings model) =
    Settings { model | additionalWrapperStyles = additionalWrapperStyles }


withContainerPosition : Css.Position {} -> Select a msg -> Select a msg
withContainerPosition position (Settings model) =
    Settings { model | containerPosition = position }


withPlaceholder : String -> Select a msg -> Select a msg
withPlaceholder placeholder (Settings model) =
    Settings { model | placeholder = Just placeholder }


withAriaLabel : String -> Select a msg -> Select a msg
withAriaLabel id (Settings model) =
    Settings { model | ariaLabel = Just id }


setOptions : List a -> Select a msg -> Select a msg
setOptions optionList (Settings ({ optionToString } as model)) =
    Settings { model | optionList = optionList |> List.Extra.unique |> List.sortBy optionToString }


view : (Msg a -> msg) -> Select a msg -> Html msg
view wrapMsg ((Settings { selectModel, isDisabled, label, optionList, borderRadius, selectedOptionViewFn, optionToString, additionalWrapperStyles, containerPosition, placeholder, isRequired, ariaLabel, maybeError }) as viewModel) =
    let
        isInvalid =
            maybeError /= Nothing

        maybeAriaActiveDescendantAttribute =
            attributeMaybe (\index -> AccessibilityUtil.ariaActiveDescendant (Model.getListboxOptionId selectModel index)) (Model.getMaybeHighlightedIndex selectModel)

        attributesBasedOnIsDisabled =
            if isDisabled then
                [ AccessibilityUtil.ariaDisabled True ]

            else
                [ Events.onClick (wrapMsg <| Toggle optionList)
                , KeyPress.onMultipleKeys KeyPress.KeyDown
                    [ ( KeyPress.ArrowDown, wrapMsg <| HandleArrowDown optionList )
                    , ( KeyPress.ArrowUp, wrapMsg HandleArrowUp )
                    , ( KeyPress.Enter, wrapMsg <| HandleEnterOrSpace optionList )
                    , ( KeyPress.Space, wrapMsg <| HandleEnterOrSpace optionList )
                    , ( KeyPress.Esc, wrapMsg Close )
                    ]
                , Attributes.tabindex 0
                , Events.onBlur (wrapMsg <| HandleOnBlur optionList)
                ]

        selectedOptionView =
            Model.getSelectedOption selectModel
                |> Maybe.map
                    (\selectedOption ->
                        selectedOptionViewFn
                            |> Maybe.map (\fn -> fn selectedOption)
                            |> Maybe.withDefault (defaultSelectedOptionView selectModel <| Just (optionToString selectedOption))
                    )
                |> Maybe.withDefault (defaultSelectedOptionView selectModel placeholder)

        maybeLabelView =
            if ariaLabel == Nothing then
                let
                    labelStyles =
                        if Model.getSelectedOption selectModel == Nothing then
                            [ Css.fontSize (Css.px 16), Css.color (Css.hex "#454545"), Css.position Css.absolute, Css.top (Css.px 22), Css.left (Css.px 16), Css.lineHeight (Css.px 12) ]

                        else
                            [ Css.fontSize (Css.px 14), Css.position Css.absolute, Css.top (Css.px -9), Css.left (Css.px 10), Css.lineHeight (Css.px 18), Css.padding2 (Css.px 0) (Css.px 6), Css.backgroundColor (Css.hex "#FFFFFF") ]
                in
                Html.span [ Attributes.css labelStyles, Attributes.id (Model.getLabelId selectModel) ] [ Html.text label, AccessibilityUtil.requiredAsterisk isRequired ]

            else
                Html.text ""

        ariaLabelAttribute =
            ariaLabel
                |> Maybe.map AccessibilityUtil.ariaLabel
                |> Maybe.withDefault (AccessibilityUtil.ariaLabelledBy (Model.getLabelId selectModel))
    in
    Html.div
        [ Attributes.css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            , Css.fontSize (Css.px 16)
            , Css.lineHeight (Css.px 12)
            , Css.property "gap" "4px"
            , Css.position containerPosition
            ]
        ]
        [ maybeLabelView
        , Html.span
            ([ Attributes.id (Model.getComboboxId selectModel)
             , Attributes.css
                ([ Css.displayFlex
                 , Css.padding2 (Css.px 12) (Css.px 16)
                 , Css.border3 (Css.px 1) Css.solid (Css.hex "#767676")
                 , Css.width (Css.pct 100)
                 , Css.borderRadius (Css.px borderRadius)
                 , Css.height (Css.px 54)
                 , disabledStyle isDisabled
                 , invalidStyle isInvalid
                 ]
                    ++ additionalWrapperStyles
                )
             , AccessibilityUtil.role "combobox"
             , AccessibilityUtil.ariaExpanded (Model.getIsOpen selectModel)
             , AccessibilityUtil.ariaHasPopup "listbox"
             , AccessibilityUtil.ariaControls (Model.getListboxId selectModel)
             , AccessibilityUtil.ariaRequired isRequired
             , AccessibilityUtil.ariaInvalid isInvalid
             , AccessibilityUtil.ariaDescribedBy (Model.getErrorId selectModel)
             , ariaLabelAttribute
             , maybeAriaActiveDescendantAttribute
             ]
                ++ attributesBasedOnIsDisabled
            )
            [ selectedOptionView ]
        , optionListView wrapMsg viewModel
        , errorView maybeError (Model.getErrorId selectModel)
        ]


errorView : Maybe String -> String -> Html msg
errorView maybeError id =
    case maybeError of
        Just error ->
            Html.span
                [ Attributes.id id
                , Attributes.css [ Css.fontSize (Css.px 14), Css.lineHeight (Css.px 18), Css.color (Css.hex "#BB0E15") ]
                ]
                [ Html.text error ]

        Nothing ->
            Html.text ""


defaultSelectedOptionView : Model a -> Maybe String -> Html msg
defaultSelectedOptionView selectModel maybeOption =
    let
        ( maybeOptionView, justifyContentStyle ) =
            case maybeOption of
                Just option ->
                    ( Html.text option, Css.justifyContent Css.spaceBetween )

                Nothing ->
                    ( Html.text "", Css.justifyContent Css.flexEnd )
    in
    Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center, Css.width (Css.pct 100), justifyContentStyle ] ]
        [ maybeOptionView
        , if Model.getIsOpen selectModel then
            Icon.arrowUp

          else
            Icon.arrowDown
        ]


optionListView : (Msg a -> msg) -> Select a msg -> Html msg
optionListView wrapMsg ((Settings { selectModel, maybeMaxHeight, borderRadius, optionList, topPx }) as viewModel) =
    let
        listboxId =
            Model.getListboxId selectModel

        divider =
            Css.Global.global
                [ Css.Global.selector ("#" ++ listboxId ++ " > *:not(:last-child)")
                    [ Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "0000001A") ]
                ]

        maxHeightStyle =
            maybeMaxHeight
                |> Maybe.map (Basics.toFloat >> Css.px >> Css.maxHeight)
                |> Maybe.withDefault (Css.batch [])
    in
    Html.div
        [ Attributes.id listboxId
        , Attributes.css
            [ Css.position Css.absolute
            , Css.top (Css.px topPx)
            , Css.width (Css.pct 100)
            , Css.left (Css.px 0)
            , Css.border3 (Css.px 1) Css.solid (Css.hex "#CCC")
            , Css.backgroundColor (Css.hex "#FFF")
            , Css.borderRadius (Css.px borderRadius)
            , Css.flexDirection Css.column
            , maxHeightStyle
            , Css.overflowY Css.auto
            , if Model.getIsOpen selectModel then
                Css.displayFlex

              else
                Css.display Css.none
            ]
        , AccessibilityUtil.role "listbox"
        , Attributes.tabindex -1
        ]
        (divider :: List.indexedMap (\index option -> optionView wrapMsg viewModel option index) optionList)


optionView : (Msg a -> msg) -> Select a msg -> a -> Int -> Html msg
optionView wrapMsg (Settings { selectModel, optionToString, optionViewFn }) option index =
    let
        listboxOptionId =
            Model.getListboxOptionId selectModel

        isSelected =
            Model.getSelectedOption selectModel |> Maybe.map (\selectedOption -> selectedOption == option) |> Maybe.withDefault False

        isHighlighted =
            Model.getMaybeHighlightedIndex selectModel |> Maybe.map ((==) index) |> Maybe.withDefault False

        highlightGlobalStyle =
            Css.Global.global
                [ Css.Global.selector ("#" ++ Model.getComboboxId selectModel ++ ":focus-visible" ++ " + #" ++ Model.getListboxId selectModel ++ " #" ++ listboxOptionId index)
                    [ defaultFocusOutline ]
                ]

        optionView_ =
            optionViewFn
                |> Maybe.map (\optionViewFn_ -> optionViewFn_ option)
                |> Maybe.withDefault (Html.text (optionToString option))
    in
    Html.div
        [ AccessibilityUtil.role "option"

        -- Prevents losing focus from the combobox span before selecting option
        , preventDefaultOn "mousedown" (wrapMsg <| Select option)
        , Attributes.id (listboxOptionId index)
        , AccessibilityUtil.ariaSelected isSelected
        , Attributes.css
            [ Css.padding (Css.px 16)
            , Css.property "gap" "8px"
            , Css.cursor Css.pointer
            , Css.displayFlex
            , Css.alignSelf Css.stretch
            , Css.alignItems Css.center
            , Css.justifyContent Css.spaceBetween
            ]
        ]
        [ optionView_
        , Icon.radioButton isSelected
        , if isHighlighted then
            highlightGlobalStyle

          else
            Html.text ""
        ]


disabledStyle : Bool -> Css.Style
disabledStyle isDisabled =
    if isDisabled then
        Css.batch
            [ Css.backgroundColor (Css.hex "#EEE")
            , Css.cursor Css.notAllowed

            -- TODO: Check if this is alright
            , Css.color (Css.hex "#767676")
            , Css.borderColor (Css.hex "#767676")
            ]

    else
        Css.batch []


invalidStyle : Bool -> Css.Style
invalidStyle isInvalid =
    if isInvalid then
        Css.batch
            [ Css.outlineColor (Css.hex "#BB0E15")
            , Css.borderColor (Css.hex "#BB0E15")
            ]

    else
        Css.batch []



-- Helpers


attributeMaybe : (a -> Attribute msg) -> Maybe a -> Attribute msg
attributeMaybe fn =
    Maybe.map fn >> Maybe.withDefault (Attributes.classList [])


preventDefaultOn : String -> msg -> Html.Attribute msg
preventDefaultOn event =
    Decode.succeed >> Decode.map alwaysPreventDefault >> Events.preventDefaultOn event


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


defaultFocusOutline : Css.Style
defaultFocusOutline =
    Css.batch
        [ Css.property "outline" "Highlight auto 2px"
        , Css.property "outline" "-webkit-focus-ring-color auto 2px"
        ]
