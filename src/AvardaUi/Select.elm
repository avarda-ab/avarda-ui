module AvardaUi.Select exposing
    ( Model, init, Msg, update, new, view
    , updateWith, onSelect, scrollOptionIntoView
    , setSelectedOption, setOptions
    , getSelectedOption
    , withMaybeError, withIsRequired, withIsDisabled, withBorderRadius, withTopPx, withMenuMaxHeight
    , withCustomOptionViewFn, withCustomSelectedOptionViewFn
    , withAdditionalWrapperStyles, withAdditionalMenuStyles, withContainerPosition, withAriaLabel
    )

{-| This module provides a customizable accessible select dropdown. It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withPlaceholder`](#withPlaceholder) or [`withIsRequired`](#withIsRequired).
3.  Finish with [`view`](#view) to render it.


# Creating a Select

@docs Model, init, Msg, update, new, view


# Update with extra options

You can pass extra options / callbacks to this component using `updateWith`

@docs updateWith, onSelect, scrollOptionIntoView


# Setting options

@docs setSelectedOption, setOptions


# Getting selected option

@docs getSelectedOption


# Configuration

@docs withMaybeError, withIsRequired, withIsDisabled, withBorderRadius, withTopPx, withMenuMaxHeight
@docs withCustomOptionViewFn, withCustomSelectedOptionViewFn
@docs withAdditionalWrapperStyles, withAdditionalMenuStyles, withContainerPosition, withAriaLabel

-}

import AvardaUi.SelectInternal.Model as Model exposing (Model)
import AvardaUi.SelectInternal.Msg as Msg exposing (Msg(..))
import AvardaUi.SelectInternal.Update as Update
import AvardaUi.Util.Accessibility as AccessibilityUtil
import AvardaUi.Util.Html as HtmlUtil
import AvardaUi.Util.Icon as Icon
import AvardaUi.Util.KeyPress as KeyPressUtil
import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Json.Decode as Decode
import List.Extra


{-| Model type for the Select component. Use this in your own model.

    type alias DashboardModel =
        { languageSelectModel : AvardaUi.Select.Model Language }

-}
type alias Model a =
    Model.Model a


{-| Msg type for the Select component. Use this for the wrap msg in your own Msg type.

    type DashboardMsg
        = HandleLanguageSelect (AvardaUi.Select.Msg Language)
        | NoUpdate

-}
type alias Msg a =
    Msg.Msg a


{-|

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandleLanguageSelect selectMsg ->
                let
                    ( updatedSelectModel, selectCmd ) =
                        AvardaUi.Select.updateWith [ AvardaUi.Select.onSelect SaveLanguageToStorage ]
                            HandleLanguageSelect
                            selectMsg
                            model.languageSelectModel
                in
                ( { model | languageSelectModel = updatedSelectModel }, selectCmd )

-}
updateWith : List (Update.UpdateOption a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWith =
    Update.updateWith


{-| Update function for the Select component. Call this in your update function to handle Select's internal messages

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandleLanguageSelect selectMsg ->
                let
                    ( updatedSelectModel, selectCmd ) =
                        AvardaUi.Select.update
                            HandleLanguageSelect
                            selectMsg
                            model.languageSelectModel
                in
                ( { model | languageSelectModel = updatedSelectModel }, selectCmd )

-}
update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    Update.update


{-| Use for triggering a message when an option is selected.
-}
onSelect : (a -> msg) -> Update.UpdateOption a msg
onSelect =
    Update.OnSelect


{-| Use to fix issue with scrolling option into view when used in ShadowDOM.
_elm/browser cannot find the element ID when this component is used by an app which uses ShadowDOM_

    type alias ScrollOptionIntoViewCmd msg =
        String -> Cmd msg

-}
scrollOptionIntoView : Update.ScrollOptionIntoViewCmd msg -> Update.UpdateOption a msg
scrollOptionIntoView =
    Update.ScrollOptionIntoView


{-| Initialize the Select model.

    init : DashboardModel
    init =
        { languageSelectModel = AvardaUi.Select.init "language" }

-}
init : String -> Model a
init =
    Model.init


{-| Set the selected option.
-}
setSelectedOption : a -> Model a -> Model a
setSelectedOption option model =
    Model.setSelectedOption option model


{-| Get the currently selected option.
If none is selected, returns _Nothing_.
-}
getSelectedOption : Model a -> Maybe a
getSelectedOption model =
    Model.getSelectedOption model


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
        , label : String
        , borderRadius : Float
        , topPx : Float
        , additionalWrapperStyles : List Css.Style
        , additionalMenuStyles : List Css.Style
        , containerPosition : Css.Position {}
        , ariaLabel : Maybe String
        }


{-| Create a new Select component.

    AvardaUi.Select.new
        { label = "Choose a language"
        , selectModel = dashboardModel.languageSelectModel
        , optionToString = .name
        }

-}
new : { label : String, selectModel : Model a, optionToString : a -> String } -> Select a msg
new { selectModel, label, optionToString } =
    let
        -- TODO: Should be part of Theme
        defaultBorderRadius =
            8

        -- TODO: In theme comment it should be default input height + some small number to offset
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
        , label = label
        , borderRadius = defaultBorderRadius
        , optionToString = optionToString
        , topPx = defaultTopPx
        , optionViewFn = Nothing
        , selectedOptionViewFn = Nothing
        , additionalWrapperStyles = []
        , additionalMenuStyles = []
        , containerPosition = Css.relative
        , ariaLabel = Nothing
        }


{-| Set a maximum height for the dropdown menu.
-}
withMenuMaxHeight : Int -> Select a msg -> Select a msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


{-| Show an error message and mark the Select as invalid.
-}
withMaybeError : Maybe String -> Select a msg -> Select a msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


{-| Mark the Select as required.
-}
withIsRequired : Select a msg -> Select a msg
withIsRequired (Settings model) =
    Settings { model | isRequired = True }


{-| Disable the select.
Visually dims and prevents user actions.
-}
withIsDisabled : Bool -> Select a msg -> Select a msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


{-| Change the border radius of the Select.
-}
withBorderRadius : Float -> Select a msg -> Select a msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


{-| Adjust the gap between the Select and the dropdown menu.
-}
withTopPx : Float -> Select a msg -> Select a msg
withTopPx topPx (Settings model) =
    Settings { model | topPx = topPx }


{-| Provide a custom view function for rendering options.
-}
withCustomOptionViewFn : (a -> Html msg) -> Select a msg -> Select a msg
withCustomOptionViewFn optionViewFn (Settings model) =
    Settings { model | optionViewFn = Just optionViewFn }


{-| Provide a custom view function for the selected option.
-}
withCustomSelectedOptionViewFn : (a -> Html msg) -> Select a msg -> Select a msg
withCustomSelectedOptionViewFn selectedOptionViewFn (Settings model) =
    Settings { model | selectedOptionViewFn = Just selectedOptionViewFn }


{-| Add additional styles.
-}
withAdditionalWrapperStyles : List Css.Style -> Select a msg -> Select a msg
withAdditionalWrapperStyles additionalWrapperStyles (Settings model) =
    Settings { model | additionalWrapperStyles = additionalWrapperStyles }


{-| Add additional menu container styles.
-}
withAdditionalMenuStyles : List Css.Style -> Select a msg -> Select a msg
withAdditionalMenuStyles additionalMenuStyles (Settings model) =
    Settings { model | additionalMenuStyles = additionalMenuStyles }


{-| Set the CSS position of the Select container.
-}
withContainerPosition : Css.Position {} -> Select a msg -> Select a msg
withContainerPosition position (Settings model) =
    Settings { model | containerPosition = position }


{-| Set a custom ARIA label (instead of label element).
-}
withAriaLabel : String -> Select a msg -> Select a msg
withAriaLabel id (Settings model) =
    Settings { model | ariaLabel = Just id }


{-| Provide a list of options to the Select.
**Note that this needs to be used as a builder, when you are creating a Select, not on init**
-}
setOptions : List a -> Select a msg -> Select a msg
setOptions optionList (Settings ({ optionToString } as model)) =
    Settings { model | optionList = optionList |> List.Extra.unique |> List.sortBy optionToString }


{-| Render the Select as HTML.

Always call this after you've built up the input with `new` and chained settings.

    AvardaUi.Select.new {...}
        |> AvardaUi.Select.withIsRequired True
        |> AvardaUi.Select.view

-}
view : (Msg a -> msg) -> Select a msg -> Html msg
view wrapMsg ((Settings { selectModel, isDisabled, label, optionList, borderRadius, selectedOptionViewFn, optionToString, additionalWrapperStyles, containerPosition, isRequired, ariaLabel, maybeError }) as viewModel) =
    let
        isInvalid =
            maybeError /= Nothing

        maybeAriaActiveDescendantAttribute =
            HtmlUtil.maybeAttribute (\index -> AccessibilityUtil.ariaActiveDescendant (Model.getListboxOptionId selectModel index)) (Model.getMaybeHighlightedIndex selectModel)

        attributesBasedOnIsDisabled =
            if isDisabled then
                [ AccessibilityUtil.ariaDisabled True ]

            else
                [ Events.onClick (wrapMsg <| Toggle optionList)
                , KeyPressUtil.onKeyDown
                    [ ( KeyPressUtil.ArrowDown, wrapMsg <| HandleArrowDown optionList )
                    , ( KeyPressUtil.ArrowUp, wrapMsg HandleArrowUp )
                    , ( KeyPressUtil.Enter, wrapMsg <| HandleEnterOrSpace optionList )
                    , ( KeyPressUtil.Space, wrapMsg <| HandleEnterOrSpace optionList )
                    , ( KeyPressUtil.Esc, wrapMsg Close )
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
                |> Maybe.withDefault (defaultSelectedOptionView selectModel Nothing)

        maybeLabelView =
            if ariaLabel == Nothing then
                let
                    labelStyles =
                        if Model.getSelectedOption selectModel == Nothing then
                            [ Css.fontSize (Css.px 16)
                            , Css.color (Css.hex "#454545")
                            , Css.position Css.absolute
                            , Css.top (Css.px 22)
                            , Css.left (Css.px 16)
                            , Css.lineHeight (Css.px 12)
                            , Css.pointerEvents Css.none
                            ]

                        else
                            [ Css.fontSize (Css.px 14)
                            , Css.position Css.absolute
                            , Css.top (Css.px -9)
                            , Css.left (Css.px 10)
                            , Css.lineHeight (Css.px 18)
                            , Css.padding2 (Css.px 0) (Css.px 6)
                            , Css.backgroundColor (Css.hex "#FFFFFF")
                            ]
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
    Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center, Css.width (Css.pct 100), justifyContentStyle, Css.color (Css.hex "#000") ] ]
        [ maybeOptionView
        , if Model.getIsOpen selectModel then
            Icon.arrowUp

          else
            Icon.arrowDown
        ]


optionListView : (Msg a -> msg) -> Select a msg -> Html msg
optionListView wrapMsg ((Settings { selectModel, maybeMaxHeight, borderRadius, optionList, topPx, additionalMenuStyles }) as viewModel) =
    let
        listboxId =
            Model.getListboxId selectModel

        dividerStyle =
            Css.Global.children
                [ Css.Global.selector "*:not(:last-child)"
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
            ([ Css.position Css.absolute
             , Css.top (Css.px topPx)
             , Css.width (Css.pct 100)
             , Css.left (Css.px 0)
             , Css.border3 (Css.px 1) Css.solid (Css.hex "#CCC")
             , Css.backgroundColor (Css.hex "#FFF")
             , Css.zIndex (Css.int 4)
             , Css.borderRadius (Css.px borderRadius)
             , Css.flexDirection Css.column
             , maxHeightStyle
             , Css.overflowY Css.auto
             , if Model.getIsOpen selectModel then
                Css.displayFlex

               else
                Css.display Css.none
             , dividerStyle
             ]
                ++ additionalMenuStyles
            )
        , AccessibilityUtil.role "listbox"
        , Attributes.tabindex -1
        ]
        (List.indexedMap (\index option -> optionView wrapMsg viewModel option index) optionList)


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
            [ Css.cursor Css.notAllowed
            , Css.opacity (Css.num 0.54)
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
