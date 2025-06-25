module Util.KeyPress exposing (KeyboardEvent(..), KeyboardKey(..), onKeyDown, onKeyDownPreventDefault, onKeyPress, onKeyPressPreventDefault, onKeyUp, onKeyUpPreventDefault)

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


onKeyPreventDefault : KeyboardEvent -> List ( KeyboardKey, msg ) -> Attribute msg
onKeyPreventDefault keyboardEvent keyMsgPairs =
    decodePressedKey keyMsgPairs
        |> Decode.map alwaysPreventDefault
        |> Events.preventDefaultOn (keyboardEventToString keyboardEvent)


onKey : KeyboardEvent -> List ( KeyboardKey, msg ) -> Attribute msg
onKey keyboardEvent keyMsgPairs =
    decodePressedKey keyMsgPairs
        |> Decode.map identity
        |> Events.on (keyboardEventToString keyboardEvent)


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


onKeyPress : List ( KeyboardKey, msg ) -> Attribute msg
onKeyPress =
    onKey KeyPress


onKeyUp : List ( KeyboardKey, msg ) -> Attribute msg
onKeyUp =
    onKey KeyUp


onKeyDown : List ( KeyboardKey, msg ) -> Attribute msg
onKeyDown =
    onKey KeyDown


onKeyDownPreventDefault : List ( KeyboardKey, msg ) -> Attribute msg
onKeyDownPreventDefault =
    onKeyPreventDefault KeyDown


onKeyUpPreventDefault : List ( KeyboardKey, msg ) -> Attribute msg
onKeyUpPreventDefault =
    onKeyPreventDefault KeyUp


onKeyPressPreventDefault : List ( KeyboardKey, msg ) -> Attribute msg
onKeyPressPreventDefault =
    onKeyPreventDefault KeyPress


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


decodePressedKey : List ( KeyboardKey, msg ) -> Decode.Decoder msg
decodePressedKey keyMsgPairs =
    Decode.map
        (\keyCode ->
            List.filter (Tuple.first >> keyboardKeyToKeyCode >> (==) keyCode) keyMsgPairs
                |> List.head
                |> Maybe.map Tuple.second
        )
        Events.keyCode
        |> Decode.andThen
            (\maybeMsg ->
                case maybeMsg of
                    Just msg ->
                        Decode.succeed msg

                    Nothing ->
                        Decode.fail "No action for this key"
            )
