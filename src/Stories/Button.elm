module Stories.Button exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as Decode
import Ui.Button
import Util.ControlsHelper exposing (ControlsFlags, ControlsModel, decodeControls, decodeStringControl)


type alias Controls =
    { label : String }


view : Controls -> Html msg
view { label } =
    Ui.Button.view label


main : Program ControlsFlags (ControlsModel Controls) msg
main =
    Browser.element
        { init =
            \flags ->
                ( { controls = decodeControls flags decoder defaultControls }, Cmd.none )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , view = \{ controls } -> view { label = controls.label }
        }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl { field = "label", fallback = defaultControls.label }


defaultControls : Controls
defaultControls =
    { label = "Click me" }
