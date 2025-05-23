module Util.ControlsHelper exposing (ControlsFlags, ControlsModel, LabelControls, decodeControls)

import Json.Decode as Decode


type alias ControlsPayload =
    { field : String, fallback : String }


type alias ControlsFlags =
    Decode.Value


type alias LabelControls =
    { label : String }


type alias ControlsModel controls =
    { controls : controls }


decodeControlWithFallback : ControlsPayload -> (String -> a) -> Decode.Decoder a
decodeControlWithFallback { field, fallback } controls =
    Decode.map (Maybe.withDefault fallback)
        (Decode.maybe (Decode.field field Decode.string))
        |> Decode.map controls


decodeControls : ControlsFlags -> ControlsPayload -> (String -> a) -> a
decodeControls flags ({ fallback } as controlsPayload) controls =
    flags
        |> Decode.decodeValue (decodeControlWithFallback controlsPayload controls)
        |> Result.withDefault (controls fallback)
