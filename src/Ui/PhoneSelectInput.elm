module Ui.PhoneSelectInput exposing (Model, Msg, init, new, onInputCallback, onInputTabKeyDownCallback, onSelectCallback, setOptions, setPhoneInputValue, setSelectedOption, update, updateWithCallbacks, view, withBorderRadius, withHint, withInputMaxLength, withInputPlaceholder, withIsDisabled, withIsRequired, withMaybeError, withMenuMaxHeight)

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import List.Extra
import Shared.Data as Data exposing (CountryCode(..))
import Task
import Ui.Input as Input
import Ui.Select as Select
import Ui.SelectInternal.Model
import Util.Components exposing (withMaybeBuilder)
import Util.Icon as Icon
import Util.KeyPress as KeyPressUtil


type Callback msg
    = OnSelect (CountryCode -> msg)
    | OnInput (String -> msg)
    | OnInputTabKeyDown msg


type alias Callbacks msg =
    { onSelect : Maybe (CountryCode -> msg)
    , onInput : Maybe (String -> msg)
    , onInputTabKeyDown : Maybe msg
    }


onSelectCallback : (CountryCode -> msg) -> Callback msg
onSelectCallback =
    OnSelect


onInputCallback : (String -> msg) -> Callback msg
onInputCallback =
    OnInput


onInputTabKeyDownCallback : msg -> Callback msg
onInputTabKeyDownCallback =
    OnInputTabKeyDown


defaultCallbacks : Callbacks msg
defaultCallbacks =
    { onSelect = Nothing, onInput = Nothing, onInputTabKeyDown = Nothing }


callbacksFromList : List (Callback msg) -> Callbacks msg
callbacksFromList =
    List.foldl
        (\opt opts ->
            case opt of
                OnSelect msg ->
                    { opts | onSelect = Just msg }

                OnInput msg ->
                    { opts | onInput = Just msg }

                OnInputTabKeyDown msg ->
                    { opts | onInputTabKeyDown = Just msg }
        )
        defaultCallbacks


type Msg
    = HandleSelect (Select.Msg CountryCode)
    | SelectedCountryCode CountryCode
    | InsertedValue String
    | InputTabKeyDown


update : (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
update =
    updateRaw (callbacksFromList [])


updateWithCallbacks : List (Callback msg) -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateWithCallbacks callbackList =
    updateRaw (callbacksFromList callbackList)


updateRaw : Callbacks msg -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateRaw { onInput, onSelect, onInputTabKeyDown } wrapMsg msg ((ModelInternal ({ selectModel } as modelInternal)) as model) =
    case msg of
        HandleSelect subMsg ->
            let
                ( updatedSelectModel, selectCmd ) =
                    Select.updateWithCallbacks [ Select.onSelectCallback SelectedCountryCode ]
                        HandleSelect
                        subMsg
                        selectModel
            in
            ( ModelInternal { modelInternal | selectModel = updatedSelectModel }, selectCmd |> Cmd.map wrapMsg )

        SelectedCountryCode countryCode ->
            ( model, maybeTriggerParentMsg onSelect countryCode )

        InsertedValue value ->
            ( ModelInternal { modelInternal | phoneInputValue = value }, maybeTriggerParentMsg onInput value )

        InputTabKeyDown ->
            ( model, maybeTriggerParentMsgWithoutValue onInputTabKeyDown )


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


type Model
    = ModelInternal
        { id : String
        , selectModel : Select.Model CountryCode
        , phoneInputValue : String
        }


getPhoneInputValue : Model -> String
getPhoneInputValue (ModelInternal { phoneInputValue }) =
    phoneInputValue


getId : Model -> String
getId (ModelInternal { id }) =
    id


getSelectModel : Model -> Select.Model CountryCode
getSelectModel (ModelInternal { selectModel }) =
    selectModel


setSelectedOption : CountryCode -> Model -> Model
setSelectedOption countryCode (ModelInternal ({ selectModel } as modelInternal)) =
    ModelInternal { modelInternal | selectModel = Select.setSelectedOption countryCode selectModel }


setPhoneInputValue : String -> Model -> Model
setPhoneInputValue value (ModelInternal modelInternal) =
    ModelInternal { modelInternal | phoneInputValue = value }


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
        }


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
        }


withMenuMaxHeight : Int -> PhoneSelectInput msg -> PhoneSelectInput msg
withMenuMaxHeight maxHeight (Settings model) =
    Settings { model | maybeMaxHeight = Just maxHeight }


withBorderRadius : Float -> PhoneSelectInput msg -> PhoneSelectInput msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


withIsRequired : Bool -> PhoneSelectInput msg -> PhoneSelectInput msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


withIsDisabled : Bool -> PhoneSelectInput msg -> PhoneSelectInput msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withMaybeError : Maybe String -> PhoneSelectInput msg -> PhoneSelectInput msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


withHint : String -> PhoneSelectInput msg -> PhoneSelectInput msg
withHint hint (Settings model) =
    Settings { model | hint = Just hint }


withInputPlaceholder : String -> PhoneSelectInput msg -> PhoneSelectInput msg
withInputPlaceholder placeholder (Settings model) =
    Settings { model | inputPlaceholder = Just placeholder }


withInputMaxLength : Int -> PhoneSelectInput msg -> PhoneSelectInput msg
withInputMaxLength maxLength (Settings model) =
    Settings { model | inputMaxLength = Just maxLength }


withMaybeBuilder : (prop -> builder -> builder) -> Maybe prop -> (builder -> builder)
withMaybeBuilder builder =
    Maybe.map builder >> Maybe.withDefault identity


setOptions : List CountryCode -> PhoneSelectInput msg -> PhoneSelectInput msg
setOptions countryCodeList (Settings model) =
    Settings { model | countryCodeList = countryCodeList |> List.Extra.unique |> List.sortBy Data.countryCodeToString }


view : (Msg -> msg) -> PhoneSelectInput msg -> Html msg
view wrapMsg (Settings { phoneSelectInputModel, selectAriaLabel, inputLabel, maybeError, isRequired, inputMaxLength, isDisabled, borderRadius, countryCodeList, maybeMaxHeight, hint, inputPlaceholder }) =
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
                |> Select.withCustomSelectedOptionViewFn (selectedOptionView selectModel isDisabled)
                |> Select.setOptions countryCodeList
                |> withMaybeBuilder Select.withMenuMaxHeight maybeMaxHeight
                |> Select.view HandleSelect
    in
    Input.new (getId phoneSelectInputModel) { value = getPhoneInputValue phoneSelectInputModel, msg = InsertedValue, label = inputLabel }
        |> Input.withLeftChild selectView
        |> Input.withAdditionalWrapperStyles [ Css.position Css.relative ]
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
        |> Input.view
        |> Html.map wrapMsg


selectedOptionView : Select.Model CountryCode -> Bool -> CountryCode -> Html msg
selectedOptionView selectModel isDisabled countryCode =
    let
        dialingCode =
            Data.countryCodeToDialingCode countryCode

        flag =
            countryCodeToIcon countryCode

        disabledStyle =
            if isDisabled then
                Css.batch [ Css.opacity (Css.num 0.5) ]

            else
                Css.batch []
    in
    Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center, Css.property "gap" "8px" ] ]
        [ Html.div [ Attributes.css [ Css.displayFlex, Css.alignItems Css.center, disabledStyle ] ]
            [ maybeFlagView flag
            , if Ui.SelectInternal.Model.getIsOpen selectModel then
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
