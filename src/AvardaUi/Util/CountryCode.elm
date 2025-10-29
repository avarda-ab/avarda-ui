module AvardaUi.Util.CountryCode exposing
    ( CountryCode(..)
    , fromString, toString, countryCodeToMaybeString
    )

{-| Utility module for handling ISO-style country codes used in the AvardaUi.PhoneSelectInput.

This module defines a `CountryCode` type representing supported countries and provides
helpers to convert between the `CountryCode` type and its two-letter string code.


# Types

@docs CountryCode


# Parsers

@docs fromString, toString, countryCodeToMaybeString

-}


{-| Supported country codes.
-}
type CountryCode
    = SE
    | FI
    | NO
    | DK
    | PL
    | EE
    | LV
    | SK
    | CZ
    | AT
    | DE
    | XI
    | GL
    | FO
    | Unknown


{-| Converts a `CountryCode` value into its corresponding two-letter string code.
Returns an empty string for `Unknown`.
-}
toString : CountryCode -> String
toString code =
    case code of
        SE ->
            "SE"

        FI ->
            "FI"

        NO ->
            "NO"

        DK ->
            "DK"

        PL ->
            "PL"

        EE ->
            "EE"

        LV ->
            "LV"

        SK ->
            "SK"

        CZ ->
            "CZ"

        AT ->
            "AT"

        DE ->
            "DE"

        XI ->
            "XI"

        GL ->
            "GL"

        FO ->
            "FO"

        Unknown ->
            ""


{-| Parses a two-letter country code string into a `CountryCode` value.
Returns `Unknown` if the string does not match any supported code.
-}
fromString : String -> CountryCode
fromString code =
    case code of
        "SE" ->
            SE

        "FI" ->
            FI

        "NO" ->
            NO

        "DK" ->
            DK

        "PL" ->
            PL

        "EE" ->
            EE

        "LV" ->
            LV

        "SK" ->
            SK

        "CZ" ->
            CZ

        "AT" ->
            AT

        "DE" ->
            DE

        "XI" ->
            XI

        "GL" ->
            GL

        "FO" ->
            FO

        _ ->
            Unknown


{-| Converts a `CountryCode` value into its corresponding two-letter string code wrapped in `Maybe`.
Returns `Nothing` for `Unknown`.
-}
countryCodeToMaybeString : CountryCode -> Maybe String
countryCodeToMaybeString countryCode =
    if countryCode == Unknown then
        Nothing

    else
        Just <| toString countryCode
