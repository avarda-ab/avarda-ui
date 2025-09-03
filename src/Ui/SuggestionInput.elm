module Ui.SuggestionInput exposing (Model, Msg, getSelectedSuggestion, init, new, onInput, onSelect, reinit, remoteSuggestions, scrollSuggestionIntoViewCmd, setInputValue, setSuggestions, update, updateWith, view, withAriaLabel, withAutocomplete, withBorderRadius, withCustomSuggestionViewFn, withHint, withIsDisabled, withIsRequired, withLeftChild, withMaybeError, withMenuMaxHeight, withPlaceholder, withRightChild, withSelectedSuggestionAdditionalStyles, withTopPx)

import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Json.Decode as Decode
import Ui.Input as Input
import Ui.SuggestionInputInternal.Model as Model exposing (Model)
import Ui.SuggestionInputInternal.Msg as Msg exposing (Msg(..))
import Ui.SuggestionInputInternal.Update as Update
import Util.Accessibility as AccessibilityUtil
import Util.Components exposing (withMaybeBuilder)
import Util.Html as HtmlUtil
import Util.KeyPress as KeyPressUtil


type alias Model a =
    Model.Model a


type alias Msg a =
    Msg.Msg a


updateWith : List (Update.UpdateOption a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWith =
    Update.updateWith


update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    Update.update


onSelect : (a -> msg) -> Update.UpdateOption a msg
onSelect =
    Update.OnSelect


onInput : (String -> msg) -> Update.UpdateOption a msg
onInput =
    Update.OnInput


remoteSuggestions : Update.RemoteSuggestionsPayload a msg -> Update.UpdateOption a msg
remoteSuggestions =
    Update.RemoteSuggestions


scrollSuggestionIntoViewCmd : Update.ScrollSuggestionIntoViewCmd msg -> Update.UpdateOption a msg
scrollSuggestionIntoViewCmd =
    Update.ScrollSuggestionIntoView


init : String -> Model a
init =
    Model.init


reinit : Model a -> Model a
reinit =
    Model.reinit


getSelectedSuggestion : Model a -> Maybe a
getSelectedSuggestion =
    Model.getSelectedSuggestion


setSuggestions : List a -> Model a -> Model a
setSuggestions suggestions model =
    Model.setSuggestions suggestions model


setInputValue : String -> Model a -> Model a
setInputValue inputValue model =
    Model.setInputValue inputValue model


type SuggestionInput a msg
    = Settings
        { suggestionInputModel : Model a
        , suggestionViewFn : Maybe (a -> Html msg)
        , suggestionToInputValue : a -> String
        , maybeError : Maybe String
        , maybeMaxHeight : Maybe Int
        , isRequired : Bool
        , isDisabled : Bool
        , label : String
        , borderRadius : Float
        , topPx : Float
        , ariaLabel : Maybe String
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , autocomplete : Maybe String
        , inputPlaceholder : Maybe String
        , hint : Maybe String
        , selectedSuggestionAdditionalStyles : List Css.Style
        }


new : { label : String, suggestionInputModel : Model a, suggestionToInputValue : a -> String } -> SuggestionInput a msg
new { suggestionInputModel, label, suggestionToInputValue } =
    let
        -- TODO: Should be part of Theme
        defaultBorderRadius =
            8

        -- TODO: In theme comment it should be default input height + some small number to offset
        defaultTopPx =
            58
    in
    Settings
        { suggestionInputModel = suggestionInputModel
        , suggestionToInputValue = suggestionToInputValue
        , borderRadius = defaultBorderRadius
        , topPx = defaultTopPx
        , suggestionViewFn = Nothing
        , maybeError = Nothing
        , maybeMaxHeight = Nothing
        , isRequired = False
        , isDisabled = False
        , label = label
        , ariaLabel = Nothing
        , leftChild = Nothing
        , rightChild = Nothing
        , autocomplete = Nothing
        , inputPlaceholder = Nothing
        , hint = Nothing
        , selectedSuggestionAdditionalStyles = []
        }


withHint : String -> SuggestionInput a msg -> SuggestionInput a msg
withHint hint (Settings model) =
    Settings { model | hint = Just hint }


withPlaceholder : String -> SuggestionInput a msg -> SuggestionInput a msg
withPlaceholder placeholder (Settings model) =
    Settings { model | inputPlaceholder = Just placeholder }


withAutocomplete : String -> SuggestionInput a msg -> SuggestionInput a msg
withAutocomplete autocomplete (Settings model) =
    Settings { model | autocomplete = Just autocomplete }


withLeftChild : Html msg -> SuggestionInput a msg -> SuggestionInput a msg
withLeftChild leftChild (Settings model) =
    Settings { model | leftChild = Just leftChild }


withRightChild : Html msg -> SuggestionInput a msg -> SuggestionInput a msg
withRightChild rightChild (Settings model) =
    Settings { model | rightChild = Just rightChild }


withMenuMaxHeight : Int -> SuggestionInput a msg -> SuggestionInput a msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


withMaybeError : Maybe String -> SuggestionInput a msg -> SuggestionInput a msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


withIsRequired : Bool -> SuggestionInput a msg -> SuggestionInput a msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


withIsDisabled : Bool -> SuggestionInput a msg -> SuggestionInput a msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withBorderRadius : Float -> SuggestionInput a msg -> SuggestionInput a msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


withTopPx : Float -> SuggestionInput a msg -> SuggestionInput a msg
withTopPx topPx (Settings model) =
    Settings { model | topPx = topPx }


withCustomSuggestionViewFn : (a -> Html msg) -> SuggestionInput a msg -> SuggestionInput a msg
withCustomSuggestionViewFn suggestionViewFn (Settings model) =
    Settings { model | suggestionViewFn = Just suggestionViewFn }


withAriaLabel : String -> SuggestionInput a msg -> SuggestionInput a msg
withAriaLabel id (Settings model) =
    Settings { model | ariaLabel = Just id }


withSelectedSuggestionAdditionalStyles : List Css.Style -> SuggestionInput a msg -> SuggestionInput a msg
withSelectedSuggestionAdditionalStyles selectedSuggestionAdditionalStyles (Settings model) =
    Settings { model | selectedSuggestionAdditionalStyles = selectedSuggestionAdditionalStyles }


view : (Msg a -> msg) -> SuggestionInput a msg -> Html msg
view wrapMsg ((Settings { suggestionInputModel, isDisabled, label, borderRadius, hint, inputPlaceholder, isRequired, autocomplete, maybeError, leftChild, rightChild, suggestionToInputValue }) as viewModel) =
    let
        maybeAriaActiveDescendantAttribute =
            HtmlUtil.maybeAttribute (\index -> AccessibilityUtil.ariaActiveDescendant (Model.getListboxOptionId suggestionInputModel index)) (Model.getMaybeHighlightedIndex suggestionInputModel)

        attributesBasedOnIsDisabled =
            if isDisabled then
                [ AccessibilityUtil.ariaDisabled True ]

            else
                [ Events.onClick (wrapMsg Toggle)
                , Events.onFocus (wrapMsg HandleOnFocus)
                , Events.onBlur (wrapMsg (HandleOnBlur suggestionToInputValue))
                , KeyPressUtil.onKeyDownPreventDefault
                    [ ( KeyPressUtil.ArrowDown, wrapMsg HandleArrowDown )
                    , ( KeyPressUtil.ArrowUp, wrapMsg HandleArrowUp )
                    , ( KeyPressUtil.Enter, wrapMsg (HandleEnter suggestionToInputValue) )
                    , ( KeyPressUtil.Esc, wrapMsg HandleEsc )
                    ]
                ]

        -- If suggestions are shown, do not show the native browser autocomplete
        maybeAutocompleteOverride =
            if Model.getIsSuggestionsExpanded suggestionInputModel then
                -- "off" isn't working in chrome, i promise
                -- https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/autocomplete#try_it
                -- click in the email field and see
                Just "disabled"

            else
                Nothing
    in
    Html.div
        [ Attributes.css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            , Css.fontSize (Css.px 16)
            , Css.lineHeight (Css.px 12)
            , Css.property "gap" "4px"
            , Css.position Css.relative
            ]
        ]
        [ Input.new (Model.getInputId suggestionInputModel) { value = Model.getInputValue suggestionInputModel, msg = InsertedValue suggestionToInputValue >> wrapMsg, label = label }
            |> Input.withAttributes
                ([ AccessibilityUtil.role "combobox"
                 , AccessibilityUtil.ariaExpanded (Model.getIsSuggestionsExpanded suggestionInputModel)
                 , AccessibilityUtil.ariaHasPopup "listbox"
                 , AccessibilityUtil.ariaControls (Model.getListboxId suggestionInputModel)
                 , AccessibilityUtil.ariaRequired isRequired
                 , AccessibilityUtil.ariaAutocompleteList
                 , maybeAriaActiveDescendantAttribute
                 ]
                    ++ attributesBasedOnIsDisabled
                )
            |> withMaybeBuilder Input.withLeftChild leftChild
            |> withMaybeBuilder Input.withRightChild rightChild
            |> Input.withAdditionalWrapperStyles [ Css.position Css.relative ]
            |> Input.withMaybeError maybeError
            |> Input.withIsDisabled isDisabled
            |> Input.withBorderRadius borderRadius
            |> withMaybeBuilder Input.withAutocomplete autocomplete
            |> withMaybeBuilder Input.withAutocomplete maybeAutocompleteOverride
            |> Input.withIsRequired isRequired
            |> withMaybeBuilder Input.withHint hint
            |> withMaybeBuilder Input.withPlaceholder inputPlaceholder
            |> Input.view
        , if List.isEmpty (Model.getFilteredSuggestions suggestionInputModel) then
            Html.text ""

          else
            suggestionListView wrapMsg viewModel
        ]


suggestionListView : (Msg a -> msg) -> SuggestionInput a msg -> Html msg
suggestionListView wrapMsg ((Settings { suggestionInputModel, maybeMaxHeight, borderRadius, topPx }) as viewModel) =
    let
        listboxId =
            Model.getListboxId suggestionInputModel

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
            [ Css.position Css.absolute
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
            , if Model.getIsSuggestionsExpanded suggestionInputModel then
                Css.displayFlex

              else
                Css.display Css.none
            , dividerStyle
            ]
        , AccessibilityUtil.role "listbox"
        , Attributes.tabindex -1
        ]
        (List.indexedMap (\index suggestion -> suggestionView wrapMsg viewModel suggestion index) (Model.getFilteredSuggestions suggestionInputModel))


suggestionView : (Msg a -> msg) -> SuggestionInput a msg -> a -> Int -> Html msg
suggestionView wrapMsg (Settings { suggestionInputModel, selectedSuggestionAdditionalStyles, suggestionViewFn, suggestionToInputValue }) suggestion index =
    let
        listboxOptionId =
            Model.getListboxOptionId suggestionInputModel

        isSelected =
            Model.getSelectedSuggestion suggestionInputModel |> Maybe.map (\selectedSuggestion -> selectedSuggestion == suggestion) |> Maybe.withDefault False

        highlightedSuggestionStyle =
            if Model.getMaybeHighlightedIndex suggestionInputModel == Just index then
                defaultFocusOutline

            else
                Css.batch []

        selectedSuggestionStyle =
            if isSelected then
                Css.batch selectedSuggestionAdditionalStyles

            else
                Css.batch []

        highlightedMatchView =
            let
                suggestionString =
                    suggestionToInputValue suggestion

                inputValue =
                    Model.getInputValue suggestionInputModel

                inputLength =
                    String.length inputValue

                indices =
                    String.indexes (String.toLower inputValue) (String.toLower suggestionString)

                ( nodes, lastPosition ) =
                    indices
                        |> List.foldl
                            (\matchIndex ( acc, position ) ->
                                let
                                    beforeMatchString =
                                        String.slice position matchIndex suggestionString

                                    matchString =
                                        String.slice matchIndex (matchIndex + inputLength) suggestionString
                                in
                                ( acc
                                    ++ [ Html.text beforeMatchString
                                       , Html.span [ Attributes.css [ Css.fontWeight Css.bold ] ] [ Html.text matchString ]
                                       ]
                                , matchIndex + inputLength
                                )
                            )
                            ( [], 0 )

                afterLastMatchString =
                    String.dropLeft lastPosition suggestionString
            in
            Html.span [] (nodes ++ [ Html.text afterLastMatchString ])
    in
    Html.div
        [ AccessibilityUtil.role "option"

        -- Prevents losing focus from the combobox span before selecting suggestion
        , preventDefaultOn "mousedown" (wrapMsg (Select suggestion suggestionToInputValue))
        , Attributes.id (listboxOptionId index)
        , AccessibilityUtil.ariaSelected isSelected
        , Attributes.css
            [ Css.padding (Css.px 12)
            , Css.minHeight (Css.px 54)
            , Css.flexShrink (Css.int 0)
            , Css.property "gap" "8px"
            , Css.cursor Css.pointer
            , Css.displayFlex
            , Css.alignSelf Css.stretch
            , Css.alignItems Css.center
            , Css.justifyContent Css.spaceBetween
            , highlightedSuggestionStyle
            , selectedSuggestionStyle
            ]
        ]
        [ suggestionViewFn
            |> Maybe.map (\suggestionViewFn_ -> suggestionViewFn_ suggestion)
            |> Maybe.withDefault highlightedMatchView
        ]



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
