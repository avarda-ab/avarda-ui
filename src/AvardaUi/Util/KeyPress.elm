module AvardaUi.Util.KeyPress exposing
    ( KeyboardKey(..)
    , onKeyDown, onKeyDownPreventDefault, onKeyUp, onKeyUpPreventDefault, onKeyPress, onKeyPressPreventDefault
    )

{-| Utility functions for handling keyboard events in Elm.

This module provides a way to bind messages to specific keys.
It exposes helpers for `keydown`, `keyup`, and `keypress` events, with or without `preventDefault`.


# KeyboardKey type

@docs KeyboardKey


# Event Handlers

@docs onKeyDown, onKeyDownPreventDefault, onKeyUp, onKeyUpPreventDefault, onKeyPress, onKeyPressPreventDefault


## Example

    import AvardaUi.Util.KeyPress as KeyPressUtil

    view : Html Msg
    view =
        Html.input
            [ KeyPressUtil.onKeyDown [ ( KeyPress.Enter, HandleSubmit ) ]
            ]
            []

-}

import Html.Styled exposing (Attribute)
import Html.Styled.Events as Events
import Json.Decode as Decode


{-| Supported keyboard keys so far.
-}
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


{-| Attach a `keypress` listener.
-}
onKeyPress : List ( KeyboardKey, msg ) -> Attribute msg
onKeyPress =
    onKey KeyPress


{-| Attach a `keyup` listener.
-}
onKeyUp : List ( KeyboardKey, msg ) -> Attribute msg
onKeyUp =
    onKey KeyUp


{-| Attach a `keydown` listener.
-}
onKeyDown : List ( KeyboardKey, msg ) -> Attribute msg
onKeyDown =
    onKey KeyDown


{-| Attach a `keydown` listener and prevent the default browser action.
-}
onKeyDownPreventDefault : List ( KeyboardKey, msg ) -> Attribute msg
onKeyDownPreventDefault =
    onKeyPreventDefault KeyDown


{-| Attach a `keyup` listener and prevent the default browser action.
-}
onKeyUpPreventDefault : List ( KeyboardKey, msg ) -> Attribute msg
onKeyUpPreventDefault =
    onKeyPreventDefault KeyUp


{-| Attach a `keypress` listener and prevent the default browser action.
-}
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
