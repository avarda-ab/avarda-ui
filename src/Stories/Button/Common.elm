module Stories.Button.Common exposing (Controls, decoder, defaultControls, view)

import AvardaUi.Button
import AvardaUi.Util.Builder exposing (withConditionalBuilder)
import AvardaUi.Util.Icon exposing (mockIconView)
import Html.Styled as Html exposing (Html)
import Json.Decode as Decode
import Util.Controls exposing (decodeBoolControl, decodeStringControl)


type alias Controls =
    { label : String
    , isDisabled : Bool
    , showIconLeft : Bool
    , showIconRight : Bool
    , size : String
    }



-- NOTE: Currently always overwritten by Button.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Click me"
    , isDisabled = False
    , showIconLeft = False
    , showIconRight = False
    , size = "large"
    }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeBoolControl "disabled"
        |> decodeBoolControl "showIconLeft"
        |> decodeBoolControl "showIconRight"
        |> decodeStringControl "size"


view : AvardaUi.Button.Variant -> Controls -> Html msg
view variant { label, isDisabled, showIconLeft, showIconRight, size } =
    let
        sizeBuilder =
            case size of
                "large" ->
                    AvardaUi.Button.withSizeLarge

                "medium" ->
                    AvardaUi.Button.withSizeMedium

                "small" ->
                    AvardaUi.Button.withSizeSmall

                _ ->
                    identity
    in
    AvardaUi.Button.new { label = label }
        |> AvardaUi.Button.withVariant variant
        |> AvardaUi.Button.withIsDisabled isDisabled
        |> withConditionalBuilder (AvardaUi.Button.withLeftChild mockIconView) showIconLeft
        |> withConditionalBuilder (AvardaUi.Button.withRightChild mockIconView) showIconRight
        |> sizeBuilder
        |> AvardaUi.Button.view
