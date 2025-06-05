module Util.Controls exposing (ControlsFlags, ControlsModel, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)

import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias ControlsFlags =
    Decode.Value


decodeStringControl : String -> Decode.Decoder (String -> b) -> Decode.Decoder b
decodeStringControl field =
    Pipeline.required field Decode.string


decodeMaybeStringControl : String -> Decode.Decoder (Maybe String -> b) -> Decode.Decoder b
decodeMaybeStringControl field =
    Pipeline.optional field (Decode.maybe Decode.string) Nothing


decodeMaybeIntControl : String -> Decode.Decoder (Maybe Int -> b) -> Decode.Decoder b
decodeMaybeIntControl field =
    Pipeline.optional field (Decode.maybe Decode.int) Nothing


decodeBoolControl : String -> Decode.Decoder (Bool -> b) -> Decode.Decoder b
decodeBoolControl field =
    Pipeline.required field Decode.bool


type alias ControlsModel controls =
    { controls : controls }


type alias ControlsModelExtended controls r =
    { r | controls : controls }


decodeControls : ControlsFlags -> Decode.Decoder a -> a -> a
decodeControls controls decoder defaultControls =
    controls
        |> Decode.decodeValue decoder
        |> Result.withDefault defaultControls
