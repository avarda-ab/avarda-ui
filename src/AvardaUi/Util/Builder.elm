module AvardaUi.Util.Builder exposing (withMaybeBuilder, withConditionalBuilder)

{-| Helpers for building components with the Elm builder pattern.

These functions make it easier to conditionally apply configuration when constructing UI components.

@docs withMaybeBuilder, withConditionalBuilder

-}


{-| Apply a builder function if there is a `Just value`.
If the value is `Nothing`, the builder is skipped.

    Input.new "username" {...}
        |> BuilderUtil.withMaybeBuilder Input.withPlaceholder (Just "Enter username")
        |> Input.view

-}
withMaybeBuilder :
    (prop -> builder -> builder)
    -> Maybe prop
    -> (builder -> builder)
withMaybeBuilder builder =
    Maybe.map builder >> Maybe.withDefault identity


{-| Apply a builder function only if a condition is `True`.
If the condition is `False`, the builder is skipped.

    Input.new "username" {...}
        |> BuilderUtil.withConditionalBuilder (Input.withLeftChild iconView) shouldShowLeftIcon
        |> Input.view

-}
withConditionalBuilder :
    (builder -> builder)
    -> Bool
    -> (builder -> builder)
withConditionalBuilder builder shouldAddBuilder =
    if shouldAddBuilder then
        builder

    else
        identity
