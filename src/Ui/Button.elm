module Ui.Button exposing (view)

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes


view : String -> Bool -> Html msg
view label isDisabled =
    Html.button [ Attributes.disabled isDisabled ] [ Html.text label ]
