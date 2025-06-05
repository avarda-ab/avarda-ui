module Shared.Data exposing (CountryCode(..), countryCodeFromString, countryCodeToDialingCode, countryCodeToString)


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


countryCodeToString : CountryCode -> String
countryCodeToString code =
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


countryCodeFromString : String -> CountryCode
countryCodeFromString code =
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


countryCodeToDialingCode : CountryCode -> String
countryCodeToDialingCode code =
    case code of
        SE ->
            "+46"

        FI ->
            "+358"

        NO ->
            "+47"

        DK ->
            "+45"

        PL ->
            "+48"

        EE ->
            "+372"

        LV ->
            "+371"

        SK ->
            "+421"

        CZ ->
            "+420"

        AT ->
            "+43"

        DE ->
            "+49"

        XI ->
            ""

        GL ->
            "+299"

        FO ->
            "+298"

        Unknown ->
            ""
