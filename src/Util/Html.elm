module Util.Html exposing (maybeAttribute)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attributes


maybeAttribute : (a -> Attribute msg) -> Maybe a -> Attribute msg
maybeAttribute fn =
    Maybe.map fn >> Maybe.withDefault (Attributes.classList [])
