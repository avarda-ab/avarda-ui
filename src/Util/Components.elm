module Util.Components exposing (withConditionalBuilder, withMaybeBuilder)


withMaybeBuilder : (prop -> builder -> builder) -> Maybe prop -> (builder -> builder)
withMaybeBuilder builder =
    Maybe.map builder >> Maybe.withDefault identity


withConditionalBuilder : (builder -> builder) -> Bool -> (builder -> builder)
withConditionalBuilder builder shouldAddBuilder =
    if shouldAddBuilder then
        builder

    else
        identity
