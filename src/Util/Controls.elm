module Util.Controls exposing (ControlsFlags, ControlsModel, decodeBoolControl, decodeControls, decodeStringControl)

import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias ControlsFlags =
    Decode.Value


decodeStringControl : String -> Decode.Decoder (String -> b) -> Decode.Decoder b
decodeStringControl field =
    Pipeline.required field Decode.string


decodeBoolControl : String -> Decode.Decoder (Bool -> b) -> Decode.Decoder b
decodeBoolControl field =
    Pipeline.required field Decode.bool



-- type alias MaybeStringControlsPayload =
--     { field : String, fallback : String }
-- type alias MaybeBoolControlsPayload =
--     { field : String, fallback : Bool }


type alias ControlsModel controls =
    { controls : controls }


decodeControls : ControlsFlags -> Decode.Decoder a -> a -> a
decodeControls flags decoder defaultControls =
    flags
        |> Decode.decodeValue decoder
        |> Result.withDefault defaultControls
