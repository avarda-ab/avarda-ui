module Ui.PhoneSelectInput exposing (CountryCode(..), Model, Msg, countryCodeFromString, init, new, onInputCallback, onSelectCallback, setOptions, setSelectedOption, update, updateWithCallbacks, view, withBorderRadius, withIsDisabled, withIsRequired, withMaxHeight, withMaybeError)

import Css exposing (maxHeight)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import List.Extra
import Task
import Ui.Input as Input
import Ui.Select as Select
import Ui.SelectInternal.Model
import Util.Components exposing (withConditionalBuilder, withMaybeBuilder)
import Util.Icon as Icon


type Callback msg
    = OnSelect (CountryCode -> msg)
    | OnInput (String -> msg)


type alias Callbacks msg =
    { onSelect : Maybe (CountryCode -> msg)
    , onInput : Maybe (String -> msg)
    }


onSelectCallback : (CountryCode -> msg) -> Callback msg
onSelectCallback =
    OnSelect


onInputCallback : (String -> msg) -> Callback msg
onInputCallback =
    OnInput


defaultCallbacks : Callbacks msg
defaultCallbacks =
    { onSelect = Nothing, onInput = Nothing }


callbacksFromList : List (Callback msg) -> Callbacks msg
callbacksFromList =
    List.foldl
        (\opt opts ->
            case opt of
                OnSelect msg ->
                    { opts | onSelect = Just msg }

                OnInput msg ->
                    { opts | onInput = Just msg }
        )
        defaultCallbacks


type Msg
    = HandleSelect (Select.Msg CountryCode)
    | SelectedCountryCode CountryCode
    | InsertedValue String


update : (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
update =
    updateRaw (callbacksFromList [])


updateWithCallbacks : List (Callback msg) -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateWithCallbacks callbackList =
    updateRaw (callbacksFromList callbackList)


updateRaw : Callbacks msg -> (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
updateRaw { onInput, onSelect } wrapMsg msg ((ModelInternal ({ selectModel } as modelInternal)) as model) =
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


maybeTriggerParentMsg : Maybe (value -> msg) -> value -> Cmd msg
maybeTriggerParentMsg maybeMsg countryCode =
    case maybeMsg of
        Just msg ->
            Task.succeed ()
                |> Task.perform (\_ -> msg countryCode)

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


init : String -> Model
init id =
    ModelInternal
        { id = id
        , selectModel = Select.init id

        -- TODO: nejspis bude potreba mit moznost poslat input value z parenta (predvyplneny value)
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
        , borderRadius : Float
        , selectAriaLabel : String
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
        , borderRadius = defaultBorderRadius
        , selectAriaLabel = selectAriaLabel
        }


withMaxHeight : Int -> PhoneSelectInput msg -> PhoneSelectInput msg
withMaxHeight maxHeight (Settings model) =
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


setOptions : List CountryCode -> PhoneSelectInput msg -> PhoneSelectInput msg
setOptions countryCodeList (Settings model) =
    Settings { model | countryCodeList = countryCodeList |> List.Extra.unique |> List.sortBy countryCodeToString }


view : (Msg -> msg) -> PhoneSelectInput msg -> Html msg
view wrapMsg (Settings { phoneSelectInputModel, selectAriaLabel, inputLabel, maybeError, isRequired, isDisabled, borderRadius, countryCodeList, maybeMaxHeight }) =
    let
        selectModel =
            getSelectModel phoneSelectInputModel

        selectView =
            Select.new { label = "", selectModel = selectModel, optionToString = countryCodeToString }
                |> Select.withIsDisabled isDisabled
                |> Select.withAriaLabel selectAriaLabel
                |> Select.withAdditionalWrapperStyles [ Css.borderStyle Css.none, Css.padding Css.zero ]
                |> Select.withWrapperPosition (Css.position Css.static)
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
        |> withConditionalBuilder Input.withIsRequired isRequired
        |> Input.view
        |> Html.map wrapMsg


selectedOptionView : Select.Model CountryCode -> Bool -> CountryCode -> Html msg
selectedOptionView selectModel isDisabled countryCode =
    let
        dialingCode =
            countryCodeToNumericalCode countryCode

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
            countryCodeToNumericalCode countryCode

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


type CountryCode
    = SE
    | FI
    | NO
    | DK
    | PL
    | EE
    | LV
    | SK
    | CZ
    | AT
    | DE
    | XI
    | GL
    | FO
    | Unknown


countryCodeToString : CountryCode -> String
countryCodeToString code =
    case code of
        SE ->
            "SE"

        FI ->
            "FI"

        NO ->
            "NO"

        DK ->
            "DK"

        PL ->
            "PL"

        EE ->
            "EE"

        LV ->
            "LV"

        SK ->
            "SK"

        CZ ->
            "CZ"

        AT ->
            "AT"

        DE ->
            "DE"

        XI ->
            "XI"

        GL ->
            "GL"

        FO ->
            "FO"

        Unknown ->
            ""


countryCodeFromString : String -> CountryCode
countryCodeFromString code =
    case code of
        "SE" ->
            SE

        "FI" ->
            FI

        "NO" ->
            NO

        "DK" ->
            DK

        "PL" ->
            PL

        "EE" ->
            EE

        "LV" ->
            LV

        "SK" ->
            SK

        "CZ" ->
            CZ

        "AT" ->
            AT

        "DE" ->
            DE

        "XI" ->
            XI

        "GL" ->
            GL

        "FO" ->
            FO

        _ ->
            Unknown


countryCodeToNumericalCode : CountryCode -> String
countryCodeToNumericalCode code =
    case code of
        SE ->
            "+46"

        FI ->
            "+358"

        NO ->
            "+47"

        DK ->
            "+45"

        PL ->
            "+48"

        EE ->
            "+372"

        LV ->
            "+371"

        SK ->
            "+421"

        CZ ->
            "+420"

        AT ->
            "+43"

        DE ->
            "+49"

        XI ->
            ""

        GL ->
            "+299"

        FO ->
            "+298"

        Unknown ->
            ""



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
