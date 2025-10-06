module AvardaUi.SuggestionInput exposing
    ( Model, init, setSuggestions, reinit, Msg, update, new, view
    , setInputValue
    , updateWith, onSelect, onInput, remoteSuggestions, scrollSuggestionIntoView
    , withBorderRadius, withHint, withPlaceholder, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight
    , getSelectedSuggestion, withAriaLabel, withAutocomplete, withCustomSuggestionViewFn, withLeftChild, withRightChild, withSelectedSuggestionAdditionalStyles, withTopPx
    )

{-| This module provides a component that allows you to get autocomplete suggestions. These can be either hardcoded or you can use remote suggestions obtained from API call.
It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withPlaceholder`](#withPlaceholder) or [`withIsRequired`](#withIsRequired).
3.  Finish with [`view`](#view) to render it.


# Creating a SuggestionInput

@docs Model, init, setSuggestions, reinit, Msg, update, new, view


# Setting suggestion list

To use it with the hardcoded list of suggestions, just [`setSuggestions`](#setSuggestions) after [`init`](#init).

    SuggestionInput.init "address"
        |> SuggestionInput.setSuggestions suggestionList

If you wish to use it with remote suggestions, add a [`remoteSuggestions`](#remoteSuggestions) update option in your [`updateWith`](#updateWith) function.

    SuggestionInput.updateWith
        [ SuggestionInput.remoteSuggestions { requestCmd = fetchSuggestions, requestMinInputLength = 3 } ]


# Setting input value

@docs setInputValue


# Update with extra options

You can pass extra options / callbacks to this component using `updateWith`

@docs updateWith, onSelect, onInput, remoteSuggestions, scrollSuggestionIntoView


# Configuration

@docs withBorderRadius, withHint, withPlaceholder, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight

-}

import AvardaUi.Input as Input
import AvardaUi.SuggestionInputInternal.Model as Model exposing (Model)
import AvardaUi.SuggestionInputInternal.Msg as Msg exposing (Msg(..))
import AvardaUi.SuggestionInputInternal.Update as Update
import AvardaUi.Util.Accessibility as AccessibilityUtil
import AvardaUi.Util.Builder exposing (withMaybeBuilder)
import AvardaUi.Util.Html as HtmlUtil
import AvardaUi.Util.KeyPress as KeyPressUtil
import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Json.Decode as Decode


{-| Model type for the SuggestionInput component. Use this in your own model.

    type alias ContactInfoModel =
        { addressSuggestionInputModel : AvardaUi.SuggestionInput.Model Address }

-}
type alias Model a =
    Model.Model a


{-| Msg type for the SuggestionInput component. Use this for the wrap msg in your own Msg type.

    type ContactInfoMsg
        = HandleAddressSuggestionInput (AvardaUi.SuggestionInput.Msg Address)
        | NoUpdate

-}
type alias Msg a =
    Msg.Msg a


{-|

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandleAddressSuggestionsInput suggestionInputMsg ->
                let
                    ( HandleAddressSuggestionInput, suggestionInputCmd ) =
                        SuggestionInput.updateWith
                            [ SuggestionInput.onInput InsertedAddress
                            , SuggestionInput.onSelect ClickedAddressSuggestion
                            ]
                            HandleAddressSuggestionsInput
                            suggestionInputMsg
                            model.addressSuggestionInputModel
                in
                ( { model | addressSuggestionInputModel = HandleAddressSuggestionInput }, suggestionInputCmd )

-}
updateWith : List (Update.UpdateOption a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWith =
    Update.updateWith


{-|

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandleAddressSuggestionsInput suggestionInputMsg ->
                let
                    ( HandleAddressSuggestionInput, suggestionInputCmd ) =
                        SuggestionInput.update
                            HandleAddressSuggestionsInput
                            suggestionInputMsg
                            model.addressSuggestionInputModel
                in
                ( { model | addressSuggestionInputModel = HandleAddressSuggestionInput }, suggestionInputCmd )

-}
update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    Update.update


{-| Used for triggering a message when suggestion is selected.
-}
onSelect : (a -> msg) -> Update.UpdateOption a msg
onSelect =
    Update.OnSelect


{-| Used for triggering a message when the input is typed into.
-}
onInput : (String -> msg) -> Update.UpdateOption a msg
onInput =
    Update.OnInput


{-| Used in [`updateWith`](#updateWith) in order to use suggestions obtain from an API call instead of hardcoded ones set with [`setSuggestions`](#setSuggestions).

The `RemoteSuggestionsPayload` looks like this:

    type alias RemoteSuggestionsPayload a msg =
        { requestCmd : String -> (RemoteData.WebData (List a) -> msg) -> Cmd msg
        , requestMinInputLength : Int
        }

where `String` is the request's query.

**Example of the `requestCmd`**:

    getAddressSuggestions : String -> (RemoteData.WebData (List Address) -> msg) -> Cmd msg
    getAddressSuggestions query msg =
        { method = "GET"
        , headers = []
        , url = "https://api.example.com/suggestions?query=" ++ query
        , body = Http.emptyBody
        , expect = Http.expectJson (RemoteData.fromResult >> msg) addressSuggestionDecoder
        , timeout = Nothing
        , tracker = Nothing
        }
            |> Http.request

-}
remoteSuggestions : Update.RemoteSuggestionsPayload a msg -> Update.UpdateOption a msg
remoteSuggestions =
    Update.RemoteSuggestions


{-| Used to fix issue with scrolling option into view when used in ShadowDOM.
_elm/browser cannot find the element ID when this component is used by an app which uses ShadowDOM_

    type alias ScrollOptionIntoViewCmd msg =
        String -> Cmd msg

-}
scrollSuggestionIntoView : Update.ScrollSuggestionIntoViewCmd msg -> Update.UpdateOption a msg
scrollSuggestionIntoView =
    Update.ScrollSuggestionIntoView


{-| Initialize the SuggestionInput model.

    init : ContactInfoModel
    init =
        { addressSuggestionInputModel = AvardaUi.SuggestionInput.init "address" }

-}
init : String -> Model a
init =
    Model.init


{-| In some cases it's nice to have the option to re-init the component with no need to pass `id` again.
-}
reinit : Model a -> Model a
reinit =
    Model.reinit


{-| Get the currently selected suggestion.
If none is selected, returns _Nothing_.
-}
getSelectedSuggestion : Model a -> Maybe a
getSelectedSuggestion =
    Model.getSelectedSuggestion


{-| Used after [`init`](#init) to use hardcoded list of suggestions.
-}
setSuggestions : List a -> Model a -> Model a
setSuggestions suggestions model =
    Model.setSuggestions suggestions model


{-| Set the input value.
-}
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


{-| Create a new SuggestionInput component.

    AvardaUi.SuggestionInput.new
        { label = "Address"
        , suggestionInputModel = addressSuggestionInputModel
        , suggestionToInputValue = .addressLine1
        }

-}
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


{-| Add a hint text below the input.
-}
withHint : String -> SuggestionInput a msg -> SuggestionInput a msg
withHint hint (Settings model) =
    Settings { model | hint = Just hint }


{-| Add a placeholder to the input.
-}
withPlaceholder : String -> SuggestionInput a msg -> SuggestionInput a msg
withPlaceholder placeholder (Settings model) =
    Settings { model | inputPlaceholder = Just placeholder }


{-| Enable autocomplete with a given string like `"address1"`. It is set to `"off"` by default.
-}
withAutocomplete : String -> SuggestionInput a msg -> SuggestionInput a msg
withAutocomplete autocomplete (Settings model) =
    Settings { model | autocomplete = Just autocomplete }


{-| Add a left-side child element.
-}
withLeftChild : Html msg -> SuggestionInput a msg -> SuggestionInput a msg
withLeftChild leftChild (Settings model) =
    Settings { model | leftChild = Just leftChild }


{-| Add a right-side child element.
-}
withRightChild : Html msg -> SuggestionInput a msg -> SuggestionInput a msg
withRightChild rightChild (Settings model) =
    Settings { model | rightChild = Just rightChild }


{-| Set a maximum height for the dropdown menu.
-}
withMenuMaxHeight : Int -> SuggestionInput a msg -> SuggestionInput a msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


{-| Show an error message and mark the input invalid.
**Replaces any active hint text.**
-}
withMaybeError : Maybe String -> SuggestionInput a msg -> SuggestionInput a msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


{-| Mark the input as required.
This adds a `*` to the label and sets `required=true`.
-}
withIsRequired : Bool -> SuggestionInput a msg -> SuggestionInput a msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


{-| Disable the input.
Visually dims and prevents user actions.
-}
withIsDisabled : Bool -> SuggestionInput a msg -> SuggestionInput a msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


{-| Adjust the border radius of the input box.
-}
withBorderRadius : Float -> SuggestionInput a msg -> SuggestionInput a msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


{-| Adjust the gap between the Select and the dropdown menu.
-}
withTopPx : Float -> SuggestionInput a msg -> SuggestionInput a msg
withTopPx topPx (Settings model) =
    Settings { model | topPx = topPx }


{-| Provide a custom view function for rendering suggestions.
-}
withCustomSuggestionViewFn : (a -> Html msg) -> SuggestionInput a msg -> SuggestionInput a msg
withCustomSuggestionViewFn suggestionViewFn (Settings model) =
    Settings { model | suggestionViewFn = Just suggestionViewFn }


{-| Set a custom ARIA label.
-}
withAriaLabel : String -> SuggestionInput a msg -> SuggestionInput a msg
withAriaLabel ariaLabel (Settings model) =
    Settings { model | ariaLabel = Just ariaLabel }


{-| Provide additional styles for the selected suggestion.
-}
withSelectedSuggestionAdditionalStyles : List Css.Style -> SuggestionInput a msg -> SuggestionInput a msg
withSelectedSuggestionAdditionalStyles selectedSuggestionAdditionalStyles (Settings model) =
    Settings { model | selectedSuggestionAdditionalStyles = selectedSuggestionAdditionalStyles }


{-| Render the Select as HTML.

Always call this after you've built up the input with `new` and chained settings.

    AvardaUi.SuggestionInput.new "address"
        |> AvardaUi.SuggestionInput.withIsRequired True
        |> AvardaUi.SuggestionInput.view

-}
view : (Msg a -> msg) -> SuggestionInput a msg -> Html msg
view wrapMsg ((Settings { suggestionInputModel, isDisabled, label, ariaLabel, borderRadius, hint, inputPlaceholder, isRequired, autocomplete, maybeError, leftChild, rightChild, suggestionToInputValue }) as viewModel) =
    let
        maybeAriaActiveDescendantAttribute =
            HtmlUtil.maybeAttribute (\index -> AccessibilityUtil.ariaActiveDescendant (Model.getListboxOptionId suggestionInputModel index)) (Model.getMaybeHighlightedIndex suggestionInputModel)

        maybeAriaLabelAttribute =
            HtmlUtil.maybeAttribute AccessibilityUtil.ariaLabel ariaLabel

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
                 , maybeAriaLabelAttribute
                 ]
                    ++ attributesBasedOnIsDisabled
                )
            |> withMaybeBuilder Input.withLeftChild leftChild
            |> withMaybeBuilder Input.withRightChild rightChild
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
