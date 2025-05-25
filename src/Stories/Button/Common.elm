module Stories.Button.Common exposing (Controls, Variant(..), decoder, defaultControls, view)

import Html.Styled as Html exposing (Html)
import Json.Decode as Decode
import Ui.Button
import Util.Components exposing (withConditionalBuilder)
import Util.Controls exposing (decodeBoolControl, decodeStringControl)
import Util.Icon exposing (mockIconView)


type alias Controls =
    { label : String
    , isDisabled : Bool
    , showIconLeft : Bool
    , showIconRight : Bool
    , size : String
    }


defaultControls : Controls
defaultControls =
    { label = "Click me"
    , isDisabled = False
    , showIconLeft = False
    , showIconRight = False
    , size = "medium"
    }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl { field = "label", fallback = defaultControls.label }
        |> decodeBoolControl { field = "disabled", fallback = defaultControls.isDisabled }
        |> decodeBoolControl { field = "showIconLeft", fallback = defaultControls.showIconLeft }
        |> decodeBoolControl { field = "showIconRight", fallback = defaultControls.showIconRight }
        |> decodeStringControl { field = "size", fallback = defaultControls.size }


type Variant
    = Primary
    | Secondary


view : Variant -> Controls -> Html msg
view variant { label, isDisabled, showIconLeft, showIconRight, size } =
    let
        newButton =
            case variant of
                Primary ->
                    Ui.Button.newPrimary { label = label }

                Secondary ->
                    Ui.Button.newSecondary { label = label }

        sizeBuilder =
            case size of
                "small" ->
                    Ui.Button.withSizeSmall

                "xsmall" ->
                    Ui.Button.withSizeXSmall

                _ ->
                    identity
    in
    newButton
        |> Ui.Button.withIsDisabled isDisabled
        |> withConditionalBuilder (Ui.Button.withLeftChild mockIconView) showIconLeft
        |> withConditionalBuilder (Ui.Button.withRightChild mockIconView) showIconRight
        |> sizeBuilder
        |> Ui.Button.withMsgTypeSubmit
        |> Ui.Button.view
