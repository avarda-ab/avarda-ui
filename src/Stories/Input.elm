module Stories.Input exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Ui.Input
import Util.Components exposing (withConditionalBuilder, withMaybeBuilder)
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)
import Util.Icon exposing (mockIconView)


type alias Controls =
    { label : String
    , placeholder : Maybe String
    , hint : Maybe String
    , error : Maybe String
    , isRequired : Bool
    , isDisabled : Bool
    , showIconLeft : Bool
    , showIconRight : Bool
    , maxLength : Maybe Int
    }



-- NOTE: Currently always overwritten by In.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Test input"
    , placeholder = Nothing
    , hint = Nothing
    , error = Nothing
    , isRequired = False
    , isDisabled = False
    , showIconLeft = False
    , showIconRight = False
    , maxLength = Nothing
    }


controlsDecoder : Decode.Decoder Controls
controlsDecoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeMaybeStringControl "placeholder"
        |> decodeMaybeStringControl "hint"
        |> decodeMaybeStringControl "error"
        |> decodeBoolControl "required"
        |> decodeBoolControl "disabled"
        |> decodeBoolControl "showIconLeft"
        |> decodeBoolControl "showIconRight"
        |> decodeMaybeIntControl "maxLength"


type alias Model =
    ControlsModelExtended Controls { value : String }


type Msg
    = InsertedValue String
    | NoOp


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        InsertedValue value ->
            ( { model | value = value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init = \controls -> ( { controls = decodeControls controls controlsDecoder defaultControls, value = "" }, Cmd.none )
        , update = \msg model -> update msg model
        , view =
            \{ value, controls } ->
                let
                    { isDisabled, isRequired, error, hint, label, placeholder, showIconLeft, showIconRight, maxLength } =
                        controls
                in
                Ui.Input.new "test-input" { value = value, msg = InsertedValue, label = label }
                    |> Ui.Input.withMaybeError error
                    |> Ui.Input.withIsDisabled isDisabled
                    |> withConditionalBuilder (Ui.Input.withLeftChild mockIconView) showIconLeft
                    |> withConditionalBuilder (Ui.Input.withRightChild mockIconView) showIconRight
                    |> Ui.Input.withIsRequired isRequired
                    |> withMaybeBuilder Ui.Input.withPlaceholder placeholder
                    |> withMaybeBuilder Ui.Input.withHint hint
                    |> withMaybeBuilder Ui.Input.withMaxLength maxLength
                    |> Ui.Input.view
                    |> List.singleton
                    |> Html.div [ Attributes.css [ Css.maxWidth (Css.px 300) ] ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
