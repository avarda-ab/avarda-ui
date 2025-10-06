module Stories.Input exposing (main)

import AvardaUi.Input
import AvardaUi.Util.Builder exposing (withConditionalBuilder, withMaybeBuilder)
import AvardaUi.Util.Icon exposing (mockIconView)
import AvardaUi.Util.KeyPress as KeyPressUtil
import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)


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
                AvardaUi.Input.new "test-input" { value = value, msg = InsertedValue, label = label }
                    |> AvardaUi.Input.withMaybeError error
                    |> AvardaUi.Input.withIsDisabled isDisabled
                    |> withConditionalBuilder (AvardaUi.Input.withLeftChild mockIconView) showIconLeft
                    |> withConditionalBuilder (AvardaUi.Input.withRightChild mockIconView) showIconRight
                    |> AvardaUi.Input.withIsRequired isRequired
                    |> withMaybeBuilder AvardaUi.Input.withPlaceholder placeholder
                    |> withMaybeBuilder AvardaUi.Input.withHint hint
                    |> withMaybeBuilder AvardaUi.Input.withMaxLength maxLength
                    |> AvardaUi.Input.withAttributes [ KeyPressUtil.onKeyDownPreventDefault [ ( KeyPressUtil.Enter, NoOp ) ] ]
                    |> AvardaUi.Input.view
                    |> List.singleton
                    |> Html.div [ Attributes.css [ Css.maxWidth (Css.px 300) ] ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
