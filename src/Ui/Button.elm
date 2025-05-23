module Ui.Button exposing (view)

import Html exposing (Html)


view : String -> Html msg
view label =
    Html.button [] [ Html.text label ]
