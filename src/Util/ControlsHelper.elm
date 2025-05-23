module Util.ControlsHelper exposing (ControlsFlags, ControlsModel, decodeBoolControl, decodeControls, decodeStringControl)

import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias ControlsFlags =
    Decode.Value


decodeStringControl : StringControlsPayload -> Decode.Decoder (String -> b) -> Decode.Decoder b
decodeStringControl { field, fallback } =
    Pipeline.optional field Decode.string fallback


decodeBoolControl : BoolControlsPayload -> Decode.Decoder (Bool -> b) -> Decode.Decoder b
decodeBoolControl { field, fallback } =
    Pipeline.optional field Decode.bool fallback


type alias StringControlsPayload =
    { field : String, fallback : String }


type alias BoolControlsPayload =
    { field : String, fallback : Bool }


type alias ControlsModel controls =
    { controls : controls }


decodeControls : ControlsFlags -> Decode.Decoder a -> a -> a
decodeControls flags decoder defaultControls =
    flags
        |> Decode.decodeValue decoder
        |> Result.withDefault defaultControls
