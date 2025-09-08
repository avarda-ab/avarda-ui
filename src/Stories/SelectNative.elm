module Stories.SelectNative exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Ui.SelectNative
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeStringControl, decodeStringControl)


type alias Controls =
    { label : String
    , placeholderOption : String
    , error : Maybe String
    , isRequired : Bool
    , isDisabled : Bool
    }



-- NOTE: Currently always overwritten by SelectNative.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Test SelectNative"
    , placeholderOption = "Placeholder option"
    , error = Nothing
    , isRequired = True
    , isDisabled = False
    }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeStringControl "placeholderOption"
        |> decodeMaybeStringControl "error"
        |> decodeBoolControl "required"
        |> decodeBoolControl "disabled"


type alias Model =
    ControlsModelExtended Controls { selectedOption : Option }


type Option
    = Option1
    | Option2
    | Option3
    | Option4
    | NoOption


optionToStringValue : Option -> String
optionToStringValue option =
    case option of
        Option1 ->
            "option1"

        Option2 ->
            "option2"

        Option3 ->
            "option3"

        Option4 ->
            "option4"

        NoOption ->
            ""


optionToLabel : String -> Option -> String
optionToLabel placeholderOption option =
    case option of
        Option1 ->
            "Option1 label"

        Option2 ->
            "Option2 label"

        Option3 ->
            "Option3 label"

        Option4 ->
            "Option4 label"

        NoOption ->
            placeholderOption


stringValueToOption : String -> Option
stringValueToOption option =
    case option of
        "option1" ->
            Option1

        "option2" ->
            Option2

        "option3" ->
            Option3

        "option4" ->
            Option4

        _ ->
            NoOption


type Msg
    = SelectedOption Option
    | NoOp


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        SelectedOption option ->
            ( { model | selectedOption = option }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init = \controls -> ( { controls = decodeControls controls decoder defaultControls, selectedOption = NoOption }, Cmd.none )
        , update = \msg model -> update msg model
        , view =
            \{ selectedOption, controls } ->
                let
                    { isDisabled, isRequired, error, label, placeholderOption } =
                        controls

                    selectedOption_ =
                        if selectedOption == NoOption then
                            Nothing

                        else
                            Just selectedOption
                in
                Ui.SelectNative.new "test-selectnative" { onChange = SelectedOption, optionToStringValue = optionToStringValue, stringValueToOption = stringValueToOption, label = label, placeholder = placeholderOption, selectedOption = selectedOption_ }
                    |> Ui.SelectNative.setBasicOptions [ Option1, Option2, Option3 ]
                    |> Ui.SelectNative.withMaybeError error
                    |> Ui.SelectNative.withIsDisabled isDisabled
                    |> Ui.SelectNative.withIsRequired isRequired
                    |> Ui.SelectNative.withOptionToLabel (optionToLabel placeholderOption)
                    |> Ui.SelectNative.view
                    |> List.singleton
                    |> Html.div [ Attributes.css [ Css.maxWidth (Css.px 300) ] ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
