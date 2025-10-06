module Stories.Button.Common exposing (Controls, Variant(..), decoder, defaultControls, view)

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
    , size = "medium"
    }


decoder : Decode.Decoder Controls
decoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeBoolControl "disabled"
        |> decodeBoolControl "showIconLeft"
        |> decodeBoolControl "showIconRight"
        |> decodeStringControl "size"


type Variant
    = Primary
    | Secondary
    | Tertiary


view : Variant -> Controls -> Html msg
view variant { label, isDisabled, showIconLeft, showIconRight, size } =
    let
        newButton =
            case variant of
                Primary ->
                    AvardaUi.Button.newPrimary { label = label }

                Secondary ->
                    AvardaUi.Button.newSecondary { label = label }

                Tertiary ->
                    AvardaUi.Button.newTertiary { label = label }

        sizeBuilder =
            case size of
                "small" ->
                    AvardaUi.Button.withSizeSmall

                "xsmall" ->
                    AvardaUi.Button.withSizeXSmall

                _ ->
                    identity
    in
    newButton
        |> AvardaUi.Button.withIsDisabled isDisabled
        |> withConditionalBuilder (AvardaUi.Button.withLeftChild mockIconView) showIconLeft
        |> withConditionalBuilder (AvardaUi.Button.withRightChild mockIconView) showIconRight
        |> sizeBuilder
        |> AvardaUi.Button.withMsgTypeSubmit
        |> AvardaUi.Button.view
