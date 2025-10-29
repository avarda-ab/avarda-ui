module AvardaUi.PhoneSelectInput exposing
    ( Model, init, Msg, update, new, view
    , updateWith, onSelect, onInput, onInputTabKeyDown, scrollOptionIntoView
    , withBorderRadius, withHint, withInputMaxLength, withInputPlaceholder, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight, withInputFloatingLabelBackgroundColor
    , setCountries, setSelectedCountry, setPhoneInputValue
    , getSelectedCountryCode, getPhoneInputValue
    )

{-| This module provides a component that combines a `Select` for country dialing codes
with an `Input` for entering a phone number. It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withPlaceholder`](#withPlaceholder) or [`withIsRequired`](#withIsRequired).
3.  Finish with [`view`](#view) to render it.


# Creating a PhoneSelectInput

@docs Model, init, Msg, update, new, view


# Update with extra options

You can pass extra options / callbacks to this component using `updateWith`

@docs updateWith, onSelect, onInput, onInputTabKeyDown, scrollOptionIntoView


# Configuration

@docs withBorderRadius, withHint, withInputMaxLength, withInputPlaceholder, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight, withInputFloatingLabelBackgroundColor


# Setting values

@docs setCountries, setSelectedCountry, setPhoneInputValue


# Getting values

@docs getSelectedCountryCode, getPhoneInputValue

-}

import AvardaUi.Input as Input
import AvardaUi.Select as Select
import AvardaUi.SelectInternal.Model
import AvardaUi.Util.Builder exposing (withMaybeBuilder)
import AvardaUi.Util.Icon as Icon
import AvardaUi.Util.KeyPress as KeyPressUtil
import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import List.Extra
import Shared.Data as Data exposing (CountryCode(..))
import Task


type UpdateOption msg
    = OnSelect (CountryCode -> msg)
    | OnInput (String -> msg)
    | OnInputTabKeyDown msg
    | ScrollOptionIntoView (ScrollOptionIntoViewCmd msg)


type alias UpdateOptions msg =
    { onSelect : Maybe (CountryCode -> msg)
    , onInput : Maybe (String -> msg)
    , onInputTabKeyDown : Maybe msg
    , scrollOptionIntoViewCmd : Maybe (ScrollOptionIntoViewCmd msg)
    }


{-| Used for triggering a message when an `CountryCode` is selected.
-}
onSelect : (CountryCode -> msg) -> UpdateOption msg
onSelect =
    OnSelect


{-| Used for triggering a message when the phone input is typed into.
-}
onInput : (String -> msg) -> UpdateOption msg
onInput =
    OnInput


{-| Used for triggering a message when `Tab` is pressed in the input.
-}
onInputTabKeyDown : msg -> UpdateOption msg
onInputTabKeyDown =
    OnInputTabKeyDown


{-| Used to fix issue with scrolling option into view when used in ShadowDOM.
_elm/browser cannot find the element ID when this component is used by an app which uses ShadowDOM_

    type alias ScrollOptionIntoViewCmd msg =
        String -> Cmd msg

-}
scrollOptionIntoView : ScrollOptionIntoViewCmd msg -> UpdateOption msg
scrollOptionIntoView =
    ScrollOptionIntoView


defaultUpdateOptions : UpdateOptions msg
defaultUpdateOptions =
    { onSelect = Nothing
    , onInput = Nothing
    , onInputTabKeyDown = Nothing
    , scrollOptionIntoViewCmd = Nothing
    }


type alias ScrollOptionIntoViewCmd msg =
    String -> Cmd msg


updateOptionsFromList : List (UpdateOption msg) -> UpdateOptions msg
updateOptionsFromList =
    List.foldl
        (\opt opts ->
            case opt of
                OnSelect msg ->
                    { opts | onSelect = Just msg }

                OnInput msg ->
                    { opts | onInput = Just msg }

                OnInputTabKeyDown msg ->
                    { opts | onInputTabKeyDown = Just msg }

                ScrollOptionIntoView scrollOptionIntoViewCmd ->
                    { opts | scrollOptionIntoViewCmd = Just scrollOptionIntoViewCmd }
        )
        defaultUpdateOptions


{-| Msg type for the PhoneSelectInput component. Use this for the wrap msg in your own Msg type.

    type DashboardMsg
        = HandlePhoneSelectInput AvardaUi.PhoneSelectInput.Msg
        | NoUpdate

-}
type Msg
    = HandleSelect (Select.Msg CountryCode)
    | SelectedCountryCode CountryCode
    | InsertedValue String
    | InputTabKeyDown


{-| Update function for the PhoneSelectInput component. Call this in your update function to handle Select's internal messages

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandlePhoneSelectInput phoneSelectInputMsg ->
                let
                    ( updatedPhoneSelectInputModel, phoneSelectInputCmd ) =
                        AvardaUi.PhoneSelectInput.update
                            HandlePhoneSelectInput
                            phoneSelectInputMsg
                            model.phoneSelectInputModel
                in
                ( { model | phoneSelectInputModel = updatedPhoneSelectInputModel }, phoneSelectInputCmd )

-}
update : (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
update =
    updateRaw (updateOptionsFromList [])


{-|

    update : Model -> Msg -> ( Model, Cmd Msg )
    update model msg =
        case msg of
            HandlePhoneSelectInput phoneSelectInputMsg ->
                let
                    ( updatedPhoneSelectInputModel, phoneSelectInputCmd ) =
                        AvardaUi.PhoneSelectInput.updateWith
                            [ AvardaUi.PhoneSelectInput.onSelect OnSelect
                            , AvardaUi.PhoneSelectInput.onInput OnInput
                            ]
                            HandlePhoneSelectInput
                            phoneSelectInputMsg
                            model.phoneSelectInputModel
                in
                ( { model | phoneSelectInputModel = updatedPhoneSelectInputModel }, selectCmd )

-}
updateWith : List (UpdateOption msg) -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateWith updateOptionList =
    updateRaw (updateOptionsFromList updateOptionList)


updateRaw : UpdateOptions msg -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateRaw updateOtions wrapMsg msg ((ModelInternal ({ selectModel } as modelInternal)) as model) =
    case msg of
        HandleSelect subMsg ->
            let
                maybeScrollOptionIntoViewCmd =
                    case updateOtions.scrollOptionIntoViewCmd of
                        Just scrollOptionIntoViewCmd_ ->
                            [ Select.scrollOptionIntoView scrollOptionIntoViewCmd_ ]

                        Nothing ->
                            []

                ( updatedSelectModel, selectCmd ) =
                    Select.updateWith (Select.onSelect (SelectedCountryCode >> wrapMsg) :: maybeScrollOptionIntoViewCmd)
                        (HandleSelect >> wrapMsg)
                        subMsg
                        selectModel
            in
            ( ModelInternal { modelInternal | selectModel = updatedSelectModel }, selectCmd )

        SelectedCountryCode countryCode ->
            ( model, maybeTriggerParentMsg updateOtions.onSelect countryCode )

        InsertedValue value ->
            ( ModelInternal { modelInternal | phoneInputValue = value }, maybeTriggerParentMsg updateOtions.onInput value )

        InputTabKeyDown ->
            ( model, maybeTriggerParentMsgWithoutValue updateOtions.onInputTabKeyDown )


maybeTriggerParentMsg : Maybe (value -> msg) -> value -> Cmd msg
maybeTriggerParentMsg maybeMsg value =
    case maybeMsg of
        Just msg ->
            Task.succeed ()
                |> Task.perform (\_ -> msg value)

        Nothing ->
            Cmd.none


maybeTriggerParentMsgWithoutValue : Maybe msg -> Cmd msg
maybeTriggerParentMsgWithoutValue maybeMsg =
    case maybeMsg of
        Just msg ->
            Task.succeed ()
                |> Task.perform (\_ -> msg)

        Nothing ->
            Cmd.none


{-| Model type for the Select component. Use this in your own model.

    type alias DashboardModel =
        { phoneSelectInputModel : AvardaUi.PhoneSelectInput.Model }

-}
type Model
    = ModelInternal
        { id : String
        , selectModel : Select.Model CountryCode
        , phoneInputValue : String
        }


{-| Get the current value of the phone input.
-}
getPhoneInputValue : Model -> String
getPhoneInputValue (ModelInternal { phoneInputValue }) =
    phoneInputValue


{-| Get the currently selected `CountryCode`.
If none is selected, returns _Nothing_.
-}
getSelectedCountryCode : Model -> Maybe CountryCode
getSelectedCountryCode (ModelInternal { selectModel }) =
    Select.getSelectedOption selectModel


getId : Model -> String
getId (ModelInternal { id }) =
    id


getSelectModel : Model -> Select.Model CountryCode
getSelectModel (ModelInternal { selectModel }) =
    selectModel


{-| Set the selected `CountryCode`.
-}
setSelectedCountry : CountryCode -> Model -> Model
setSelectedCountry countryCode (ModelInternal ({ selectModel } as modelInternal)) =
    ModelInternal { modelInternal | selectModel = Select.setSelectedOption countryCode selectModel }


{-| Set the phone input value.
-}
setPhoneInputValue : String -> Model -> Model
setPhoneInputValue value (ModelInternal modelInternal) =
    ModelInternal { modelInternal | phoneInputValue = value }


{-| Initialize the PhoneSelectInput model.

    init : DashboardModel
    init =
        { phoneSelectInputModel = AvardaUi.PhoneSelectInput.init "phone" }

-}
init : String -> Model
init id =
    ModelInternal
        { id = id
        , selectModel = Select.init id
        , phoneInputValue = ""
        }


type PhoneSelectInput msg
    = Settings
        { phoneSelectInputModel : Model
        , countryCodeList : List CountryCode
        , maybeError : Maybe String
        , maybeMaxHeight : Maybe Int
        , isRequired : Bool
        , isDisabled : Bool
        , inputLabel : String
        , inputPlaceholder : Maybe String
        , borderRadius : Float
        , selectAriaLabel : String
        , hint : Maybe String
        , inputMaxLength : Maybe Int
        , inputFloatingLabelBackgroundColor : Css.Color
        }


{-| Create a new PhoneSelectInput component.

    AvardaUi.PhoneSelectInput.new
        { inputLabel = "Phone"
        , selectAriaLabel = "Country code"
        , phoneSelectInputModel = model.phoneSelectInputModel
        }

-}
new : { inputLabel : String, selectAriaLabel : String, phoneSelectInputModel : Model } -> PhoneSelectInput msg
new { inputLabel, selectAriaLabel, phoneSelectInputModel } =
    let
        defaultBorderRadius =
            8
    in
    Settings
        { phoneSelectInputModel = phoneSelectInputModel
        , countryCodeList = []
        , maybeError = Nothing
        , maybeMaxHeight = Nothing
        , isRequired = False
        , isDisabled = False
        , inputLabel = inputLabel
        , inputPlaceholder = Nothing
        , borderRadius = defaultBorderRadius
        , selectAriaLabel = selectAriaLabel
        , hint = Nothing
        , inputMaxLength = Nothing
        , inputFloatingLabelBackgroundColor = Css.hex "#FFFFFF"
        }


{-| Set a maximum height for the dropdown menu.
-}
withMenuMaxHeight : Int -> PhoneSelectInput msg -> PhoneSelectInput msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


{-| Adjust the border radius of the PhoneSelectInput.
-}
withBorderRadius : Float -> PhoneSelectInput msg -> PhoneSelectInput msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


{-| Mark the PhoneSelectInput as required.
-}
withIsRequired : Bool -> PhoneSelectInput msg -> PhoneSelectInput msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


{-| Disable the PhoneSelectInput
-}
withIsDisabled : Bool -> PhoneSelectInput msg -> PhoneSelectInput msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


{-| Show an error message and mark the PhoneSelectInput as invalid.
**Replaces any active hint text.**
-}
withMaybeError : Maybe String -> PhoneSelectInput msg -> PhoneSelectInput msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


{-| Add a hint text below the PhoneSelectInput.
-}
withHint : String -> PhoneSelectInput msg -> PhoneSelectInput msg
withHint hint (Settings model) =
    Settings { model | hint = Just hint }


{-| Add a placeholder to the input.
-}
withInputPlaceholder : String -> PhoneSelectInput msg -> PhoneSelectInput msg
withInputPlaceholder placeholder (Settings model) =
    Settings { model | inputPlaceholder = Just placeholder }


{-| Limit the maximum number of characters.
-}
withInputMaxLength : Int -> PhoneSelectInput msg -> PhoneSelectInput msg
withInputMaxLength maxLength (Settings model) =
    Settings { model | inputMaxLength = Just maxLength }


{-| Sets the background color of the floating input label.
This is useful when the color of the background behind the input is something else then `#FFFFFF`.
-}
withInputFloatingLabelBackgroundColor : Css.Color -> PhoneSelectInput msg -> PhoneSelectInput msg
withInputFloatingLabelBackgroundColor color (Settings model) =
    Settings { model | inputFloatingLabelBackgroundColor = color }


{-| Set the available `CountryCode`s for country select.
-}
setCountries : List CountryCode -> PhoneSelectInput msg -> PhoneSelectInput msg
setCountries countryCodeList (Settings model) =
    Settings { model | countryCodeList = countryCodeList |> List.Extra.unique |> List.sortBy Data.countryCodeToString }


{-| Render the PhoneSelectInput as HTML .

Always call this after you've built up the input with `new` and chained settings.

    AvardaUi.PhoneSelectInput.new "phone" {...}
        |> AvardaUi.PhoneSelectInput.withIsRequired True
        |> AvardaUi.PhoneSelectInput.view

-}
view : (Msg -> msg) -> PhoneSelectInput msg -> Html msg
view wrapMsg (Settings { phoneSelectInputModel, selectAriaLabel, inputLabel, maybeError, isRequired, inputMaxLength, isDisabled, borderRadius, countryCodeList, maybeMaxHeight, hint, inputPlaceholder, inputFloatingLabelBackgroundColor }) =
    let
        selectModel =
            getSelectModel phoneSelectInputModel

        selectView =
            Select.new { label = "", selectModel = selectModel, optionToString = Data.countryCodeToString }
                |> Select.withIsDisabled isDisabled
                |> Select.withAriaLabel selectAriaLabel
                |> Select.withAdditionalWrapperStyles [ Css.borderStyle Css.none, Css.padding Css.zero ]
                |> Select.withContainerPosition Css.static
                |> Select.withCustomOptionViewFn optionView
                |> Select.withCustomSelectedOptionViewFn (selectedOptionView selectModel)
                |> Select.setOptions countryCodeList
                |> withMaybeBuilder Select.withMenuMaxHeight maybeMaxHeight
                |> Select.view HandleSelect
    in
    Input.new (getId phoneSelectInputModel) { value = getPhoneInputValue phoneSelectInputModel, msg = InsertedValue, label = inputLabel }
        |> Input.withLeftChild selectView
        |> Input.withMaybeError maybeError
        |> Input.withIsDisabled isDisabled
        |> Input.withBorderRadius borderRadius
        |> Input.withInputType "tel"
        |> Input.withAutocomplete "tel-national"
        |> Input.withAttributes [ Attributes.name "phone" ]
        |> Input.withIsRequired isRequired
        |> Input.withOnKeyDown [ ( KeyPressUtil.Tab, InputTabKeyDown ) ]
        |> withMaybeBuilder Input.withHint hint
        |> withMaybeBuilder Input.withPlaceholder inputPlaceholder
        |> withMaybeBuilder Input.withMaxLength inputMaxLength
        |> Input.withFloatingLabelBackgroundColor inputFloatingLabelBackgroundColor
        |> Input.view
        |> Html.map wrapMsg


selectedOptionView : Select.Model CountryCode -> CountryCode -> Html msg
selectedOptionView selectModel countryCode =
    let
        dialingCode =
            Data.countryCodeToDialingCode countryCode

        flag =
            countryCodeToIcon countryCode
    in
    Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center, Css.property "gap" "4px" ] ]
        [ Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center ] ]
            [ maybeFlagView flag
            , if AvardaUi.SelectInternal.Model.getIsOpen selectModel then
                Icon.arrowUp

              else
                Icon.arrowDown
            ]
        , Html.text dialingCode
        ]


optionView : CountryCode -> Html msg
optionView countryCode =
    let
        dialingCode =
            Data.countryCodeToDialingCode countryCode

        flag =
            countryCodeToIcon countryCode
    in
    Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.row, Css.alignItems Css.center ] ]
        [ maybeFlagView flag
        , Html.text <| "(" ++ dialingCode ++ ")"
        ]


maybeFlagView : Maybe (Html msg) -> Html msg
maybeFlagView maybeFlag =
    maybeFlag
        |> Maybe.map (\flag -> Html.div [ Attributes.css [ Css.padding2 (Css.px 5) (Css.px 3) ] ] [ flag ])
        |> Maybe.withDefault (Html.text "")



-- TODO: This should always return an icon i guess


countryCodeToIcon : CountryCode -> Maybe (Html msg)
countryCodeToIcon code =
    case code of
        SE ->
            Just Icon.swedenFlag

        FI ->
            Just Icon.finlandFlag

        NO ->
            Just Icon.norwayFlag

        DK ->
            Just Icon.denmarkFlag

        PL ->
            Nothing

        EE ->
            Nothing

        LV ->
            Nothing

        SK ->
            Nothing

        CZ ->
            Nothing

        AT ->
            Nothing

        DE ->
            Nothing

        XI ->
            Nothing

        GL ->
            Just Icon.greenlandFlag

        FO ->
            Just Icon.faroeIslandsFlag

        Unknown ->
            Nothing
