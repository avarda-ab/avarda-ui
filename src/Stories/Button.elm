module Stories.Button exposing (main)

import Browser
import Html exposing (Html)
import Ui.Button
import Util.ControlsHelper exposing (ControlsFlags, ControlsModel, LabelControls, decodeControls)



-- Define your controls with defaults


type Msg
    = UserClickedButton


view : LabelControls -> Html Msg
view { label } =
    Ui.Button.view label


main : Program ControlsFlags (ControlsModel LabelControls) Msg
main =
    Browser.element
        { init =
            \flags ->
                ( { controls = decodeControls flags { field = "label", fallback = "Click me" } LabelControls }, Cmd.none )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , view = \{ controls } -> view { label = controls.label }
        }
