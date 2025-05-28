module Util.KeyPress exposing (KeyboardEvent(..), KeyboardKey(..), onKeyDown, onKeyPress, onKeyUp, onMultipleKeys)

import Html.Styled exposing (Attribute)
import Html.Styled.Events as Events
import Json.Decode as Decode


type KeyboardKey
    = Enter
    | Esc
    | ArrowUp
    | ArrowDown
    | Tab
    | Space


type KeyboardEvent
    = KeyPress
    | KeyUp
    | KeyDown


keyboardEventToString : KeyboardEvent -> String
keyboardEventToString keyboardEvent =
    case keyboardEvent of
        KeyPress ->
            "keypress"

        KeyUp ->
            "keyup"

        KeyDown ->
            "keydown"


onKey : KeyboardEvent -> List KeyboardKey -> msg -> Attribute msg
onKey keyboardEvent keyboardKeys msg =
    decodePressedKey keyboardKeys msg
        |> Decode.map alwaysPreventDefault
        |> Events.preventDefaultOn (keyboardEventToString keyboardEvent)


onMultipleKeys : KeyboardEvent -> List ( KeyboardKey, msg ) -> Attribute msg
onMultipleKeys keyboardEvent keyboardKeysWithMsg =
    keyboardKeysWithMsg
        |> List.map
            (\( keyboardKey, msg ) ->
                decodePressedKey [ keyboardKey ] msg
                    |> Decode.map alwaysPreventDefault
            )
        |> Decode.oneOf
        |> Events.preventDefaultOn (keyboardEventToString keyboardEvent)


keyboardKeyToKeyCode : KeyboardKey -> Int
keyboardKeyToKeyCode keyboardKey =
    case keyboardKey of
        Enter ->
            13

        Esc ->
            27

        ArrowUp ->
            38

        ArrowDown ->
            40

        Tab ->
            9

        Space ->
            32


onKeyPress : List KeyboardKey -> msg -> Attribute msg
onKeyPress =
    onKey KeyPress


onKeyUp : List KeyboardKey -> msg -> Attribute msg
onKeyUp =
    onKey KeyUp


onKeyDown : List KeyboardKey -> msg -> Attribute msg
onKeyDown =
    onKey KeyDown


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


hasKey : Int -> List KeyboardKey -> Bool
hasKey keyCode =
    List.map keyboardKeyToKeyCode
        >> List.member keyCode


decodePressedKey : List KeyboardKey -> msg -> Decode.Decoder msg
decodePressedKey keyboardKeys msg =
    Events.keyCode
        |> Decode.andThen
            (\keyCode ->
                if hasKey keyCode keyboardKeys then
                    Decode.succeed msg

                else
                    Decode.fail "Key not pressed"
            )
