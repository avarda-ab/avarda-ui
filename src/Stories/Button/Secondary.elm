module Stories.Button.Secondary exposing (main)

import AvardaUi.Button
import Browser
import Html.Styled as Html
import Stories.Button.Common as Common
import Util.Controls exposing (ControlsFlags, ControlsModel, decodeControls)


main : Program ControlsFlags (ControlsModel Common.Controls) msg
main =
    Browser.element
        { init = \controls -> ( { controls = decodeControls controls Common.decoder Common.defaultControls }, Cmd.none )
        , update = \_ model -> ( model, Cmd.none )
        , view = .controls >> Common.view AvardaUi.Button.Secondary >> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
