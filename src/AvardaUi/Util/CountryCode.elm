module AvardaUi.Util.CountryCode exposing
    ( CountryCode(..)
    , fromString, toString, toMaybeString
    , fromThreeLetterISOString, toThreeLetterISOString, toMaybeThreeLetterIsoString
    )

{-| Utility module for handling ISO-style country codes used in the AvardaUi.PhoneSelectInput.

This module defines a `CountryCode` type representing supported countries and provides
helpers to convert between the `CountryCode` type and its two-letter string code.


# Types

@docs CountryCode


# Two-letter ISO Parsers

@docs fromString, toString, toMaybeString


# Three-letter ISO Parsers

@docs fromThreeLetterISOString, toThreeLetterISOString, toMaybeThreeLetterIsoString

-}


{-| Supported country codes.
-}
type CountryCode
    = AT
    | CZ
    | DE
    | DK
    | EE
    | ES
    | FI
    | FO
    | GB
    | GL
    | IT
    | LV
    | NO
    | PL
    | SE
    | SK
    | XI
    | Unknown


{-| Converts a `CountryCode` value into its corresponding two-letter ISO string code.
Returns an empty string for `Unknown`.
-}
toString : CountryCode -> String
toString code =
    case code of
        AT ->
            "AT"

        CZ ->
            "CZ"

        DE ->
            "DE"

        DK ->
            "DK"

        EE ->
            "EE"

        ES ->
            "ES"

        FI ->
            "FI"

        FO ->
            "FO"

        GB ->
            "GB"

        GL ->
            "GL"

        IT ->
            "IT"

        LV ->
            "LV"

        NO ->
            "NO"

        PL ->
            "PL"

        SE ->
            "SE"

        SK ->
            "SK"

        XI ->
            "XI"

        Unknown ->
            ""


{-| Parses a two-letter ISO country code string into a `CountryCode` value.
Returns `Unknown` if the string does not match any supported code.
-}
fromString : String -> CountryCode
fromString code =
    case code of
        "AT" ->
            AT

        "CZ" ->
            CZ

        "DE" ->
            DE

        "DK" ->
            DK

        "EE" ->
            EE

        "ES" ->
            ES

        "FI" ->
            FI

        "FO" ->
            FO

        "GB" ->
            GB

        "GL" ->
            GL

        "IT" ->
            IT

        "LV" ->
            LV

        "NO" ->
            NO

        "PL" ->
            PL

        "SE" ->
            SE

        "SK" ->
            SK

        "XI" ->
            XI

        _ ->
            Unknown


{-| Parses a three-letter ISO country code string into a `CountryCode` value.
Returns `Unknown` if the string does not match any supported code.
-}
fromThreeLetterISOString : String -> CountryCode
fromThreeLetterISOString code =
    case code of
        "AUT" ->
            AT

        "CZE" ->
            CZ

        "DEU" ->
            DE

        "DNK" ->
            DK

        "EST" ->
            EE

        "ESP" ->
            ES

        "FIN" ->
            FI

        "FRO" ->
            FO

        "GBR" ->
            GB

        "GRL" ->
            GL

        "ITA" ->
            IT

        "LVA" ->
            LV

        "NOR" ->
            NO

        "POL" ->
            PL

        "SWE" ->
            SE

        "SVK" ->
            SK

        _ ->
            Unknown


{-| Converts a `CountryCode` value into its corresponding three-letter ISO string code.
Returns an empty string for `Unknown` and `XI`.
-}
toThreeLetterISOString : CountryCode -> String
toThreeLetterISOString code =
    case code of
        AT ->
            "AUT"

        CZ ->
            "CZE"

        DE ->
            "DEU"

        DK ->
            "DNK"

        EE ->
            "EST"

        ES ->
            "ESP"

        FI ->
            "FIN"

        FO ->
            "FRO"

        GB ->
            "GBR"

        GL ->
            "GRL"

        IT ->
            "ITA"

        LV ->
            "LVA"

        NO ->
            "NOR"

        PL ->
            "POL"

        SE ->
            "SWE"

        SK ->
            "SVK"

        -- not sure about this one, its a Checkout3 thing
        XI ->
            ""

        Unknown ->
            ""


{-| Converts a `CountryCode` value into its corresponding two-letter ISO string code wrapped in `Maybe`.
Returns `Nothing` for `Unknown`.
-}
toMaybeString : CountryCode -> Maybe String
toMaybeString countryCode =
    if countryCode == Unknown then
        Nothing

    else
        Just <| toString countryCode


{-| Converts a `CountryCode` value into its corresponding three-letter ISO string code wrapped in `Maybe`.
Returns `Nothing` for `Unknown` and `XI`.
-}
toMaybeThreeLetterIsoString : CountryCode -> Maybe String
toMaybeThreeLetterIsoString countryCode =
    if countryCode == Unknown || countryCode == XI then
        Nothing

    else
        Just <| toString countryCode
