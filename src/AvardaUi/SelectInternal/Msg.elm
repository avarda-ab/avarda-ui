module AvardaUi.SelectInternal.Msg exposing (Msg(..))


type Msg a
    = Close
    | Toggle (List a)
    | Select a
    | HandleArrowDown (List a)
    | HandleArrowUp
    | HandleEnterOrSpace (List a)
    | HandleOnBlur (List a)
    | NoUpdate
