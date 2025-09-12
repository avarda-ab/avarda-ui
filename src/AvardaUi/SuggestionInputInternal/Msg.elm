module AvardaUi.SuggestionInputInternal.Msg exposing (Msg(..))

import RemoteData


type Msg a
    = Toggle
    | Select a (a -> String)
    | HandleArrowDown
    | HandleArrowUp
    | HandleEnter (a -> String)
    | HandleEsc
    | HandleOnBlur (a -> String)
    | HandleOnFocus
    | InsertedValue (a -> String) String
    | InsertedValueDebounced (a -> String) String
    | GotRequestResponse (RemoteData.WebData (List a))
    | NoUpdate
