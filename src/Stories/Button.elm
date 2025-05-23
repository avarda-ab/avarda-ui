module Stories.Button exposing (main)

import Browser
import Html.Styled as Html exposing (Html)
import Json.Decode as Decode
import Ui.Button
import Util.ControlsHelper exposing (ControlsFlags, ControlsModel, decodeBoolControl, decodeControls, decodeStringControl)


type alias Controls =
    { label : String, isDisabled : Bool }


view : Controls -> Html msg
view { label, isDisabled } =
    Ui.Button.view label isDisabled


main : Program ControlsFlags (ControlsModel Controls) msg
main =
    Browser.element
        { init =
            \flags ->
                ( { controls = decodeControls flags decoder defaultControls }, Cmd.none )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , view = \{ controls } -> view { label = controls.label, isDisabled = controls.isDisabled } |> Html.toUnstyled
        }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl { field = "label", fallback = defaultControls.label }
        |> decodeBoolControl { field = "disabled", fallback = defaultControls.isDisabled }


defaultControls : Controls
defaultControls =
    { label = "Click me", isDisabled = False }
