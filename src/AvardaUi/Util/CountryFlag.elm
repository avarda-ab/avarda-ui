module AvardaUi.Util.CountryFlag exposing (austria, czechia, denmark, estonia, faroeIslands, finland, germany, greenland, iceland, italy, latvia, norway, poland, slovakia, spain, sweden, unitedKingdom)

{-| Utility module which includes all of our country flag icons.


# Flags

These flags have fixed width and height and are of type `Html msg`.

@docs austria, czechia, denmark, estonia, faroeIslands, finland, germany, greenland, iceland, italy, latvia, norway, poland, slovakia, spain, sweden, unitedKingdom

-}

import Css
import Html.Styled exposing (Html)
import Html.Styled.Attributes as HtmlAttributes
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttributes


{-| -}
sweden : Html msg
sweden =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 5v5.5H3v3h4.5V19h3v-5.5H21v-3H10.5V5z"
                    , SvgAttributes.fill "#ffcb00"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#005293"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_45"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_45"
                    , SvgAttributes.result "effect2_dropShadow_1726_45"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_45"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
denmark : Html msg
denmark =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 5v5.5H3v3h4.5V19h3v-5.5H21v-3H10.5V5z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#ef264d"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_41"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_41"
                    , SvgAttributes.result "effect2_dropShadow_1726_41"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_41"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
norway : Html msg
norway =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#f14247"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 10.5V5h1v6.5H3v-1zm-4.5 2v1h4.5V19h1v-6.5zM9.5 19h1v-5.5H21v-1H9.5zM21 11.5v-1H10.5V5h-1v6.5z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 5v6.5H3v1h5.5V19h1v-6.5H21v-1H9.5V5z"
                    , SvgAttributes.fill "#0a3a85"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_47"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_47"
                    , SvgAttributes.result "effect2_dropShadow_1726_47"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_47"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
finland : Html msg
finland =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 5v5.5H3v3h4.5V19h3v-5.5H21v-3H10.5V5z"
                    , SvgAttributes.fill "#0e4cb5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_46"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_46"
                    , SvgAttributes.result "effect2_dropShadow_1726_46"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_46"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
greenland : Html msg
greenland =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.rect
                [ SvgAttributes.x "3"
                , SvgAttributes.y "5"
                , SvgAttributes.width "18"
                , SvgAttributes.height "14"
                , SvgAttributes.rx "2"
                , SvgAttributes.fill "#fff"
                ]
                []
            , Svg.path
                [ SvgAttributes.fill "#d80027"
                , SvgAttributes.d "M3 12h18v7H3z"
                ]
                []
            , Svg.path
                [ SvgAttributes.fillRule "evenodd"
                , SvgAttributes.clipRule "evenodd"
                , SvgAttributes.d "M5 12h10a5 5 0 0 0-10 0"
                , SvgAttributes.fill "#d80027"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M10 17a5 5 0 0 0 5-5H5a5 5 0 0 0 5 5"
                , SvgAttributes.fill "#fff"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_50"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_50"
                    , SvgAttributes.result "effect2_dropShadow_1726_50"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_50"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
faroeIslands : Html msg
faroeIslands =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 10.5V5h1v6.5H3v-1zm-4.5 2v1h4.5V19h1v-6.5zM9.5 19h1v-5.5H21v-1H9.5zM21 11.5v-1H10.5V5h-1v6.5z"
                    , SvgAttributes.fill "#0e4cb5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 5v6.5H3v1h5.5V19h1v-6.5H21v-1H9.5V5z"
                    , SvgAttributes.fill "#eb363a"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_44"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_44"
                    , SvgAttributes.result "effect2_dropShadow_1726_44"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_44"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
unitedKingdom : Html msg
unitedKingdom =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#0a17a7"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 5 3 19m18 0L3 5"
                    , SvgAttributes.stroke "#fff"
                    , SvgAttributes.strokeWidth "2"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "m21 5.5-9 7m9 6-9-7m-9-6 9 7m-9 6 9-7"
                    , SvgAttributes.stroke "#db1f35"
                    , SvgAttributes.strokeWidth ".5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M3 14h7v5h4v-5h7v-4h-7V5h-4v5H3z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M3 13h8v6h2v-6h8v-2h-8V5h-2v6H3z"
                    , SvgAttributes.fill "#db1f35"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_52"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_52"
                    , SvgAttributes.result "effect2_dropShadow_1726_52"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_52"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
germany : Html msg
germany =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#ffda44"
                    , SvgAttributes.d "M3 14.5h18V19H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M3 9.5h18v5H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#000"
                    , SvgAttributes.d "M3 5h18v4.5H3z"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_42"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_42"
                    , SvgAttributes.result "effect2_dropShadow_1726_42"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_42"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
italy : Html msg
italy =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M15 5h6v14h-6z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M9 5h6v14H9z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#6da544"
                    , SvgAttributes.d "M3 5h6v14H3z"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_48"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_48"
                    , SvgAttributes.result "effect2_dropShadow_1726_48"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_48"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
spain : Html msg
spain =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M3 15h18v4H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#ffda44"
                    , SvgAttributes.d "M3 9h18v6H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M3 5h18v4H3z"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_49"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_49"
                    , SvgAttributes.result "effect2_dropShadow_1726_49"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_49"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
austria : Html msg
austria =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M3 14.5h18V19H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M3 9.5h18v5H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#d80027"
                    , SvgAttributes.d "M3 5h18v4.5H3z"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_51"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_51"
                    , SvgAttributes.result "effect2_dropShadow_1726_51"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_51"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
czechia : Html msg
czechia =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 640 480"
        , SvgAttributes.fill "none"
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 2) ]
        ]
        [ Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M0 0h640v240H0z" ] []
        , Svg.path [ SvgAttributes.fill "#d7141a", SvgAttributes.d "M0 240h640v240H0z" ] []
        , Svg.path [ SvgAttributes.fill "#11457e", SvgAttributes.d "M360 240 0 0v480z" ] []
        ]


{-| -}
estonia : Html msg
estonia =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#000"
                    , SvgAttributes.d "M3 14.5h18V19H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M3 9.5h18v5H3z"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fill "#5da8f1"
                    , SvgAttributes.d "M3 5h18v4.5H3z"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1758_43"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1758_43"
                    , SvgAttributes.result "effect2_dropShadow_1758_43"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1758_43"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
latvia : Html msg
latvia =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 640 480"
        , SvgAttributes.fill "none"
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 2) ]
        ]
        [ Svg.g [ SvgAttributes.fillRule "evenodd" ]
            [ Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M0 0h640v480H0z" ] []
            , Svg.path [ SvgAttributes.fill "#981e32", SvgAttributes.d "M0 0h640v192H0zm0 288h640v192H0z" ] []
            ]
        ]


{-| -}
poland : Html msg
poland =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.rect
                [ SvgAttributes.x "3"
                , SvgAttributes.y "5"
                , SvgAttributes.width "18"
                , SvgAttributes.height "14"
                , SvgAttributes.rx "2"
                , SvgAttributes.fill "#fff"
                ]
                []
            , Svg.path
                [ SvgAttributes.fill "#d80027"
                , SvgAttributes.d "M3 12h18v7H3z"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1789_16"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1789_16"
                    , SvgAttributes.result "effect2_dropShadow_1789_16"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1789_16"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]


{-| -}
slovakia : Html msg
slovakia =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 640 480"
        , SvgAttributes.fill "none"
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 2) ]
        ]
        [ Svg.path [ SvgAttributes.fill "#ee1c25", SvgAttributes.d "M0 0h640v480H0z" ] []
        , Svg.path [ SvgAttributes.fill "#0b4ea2", SvgAttributes.d "M0 0h640v320H0z" ] []
        , Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M0 0h640v160H0z" ] []
        , Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M233 370.8c-43-20.7-104.6-61.9-104.6-143.2 0-81.4 4-118.4 4-118.4h201.3s3.9 37 3.9 118.4S276 350 233 370.8z" ] []
        , Svg.path [ SvgAttributes.fill "#ee1c25", SvgAttributes.d "M233 360c-39.5-19-96-56.8-96-131.4s3.6-108.6 3.6-108.6h184.8s3.5 34 3.5 108.6C329 303.3 272.5 341 233 360z" ] []
        , Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M241.4 209c10.7.2 31.6.6 50.1-5.6 0 0-.4 6.7-.4 14.4s.5 14.4.5 14.4c-17-5.7-38.1-5.8-50.2-5.7v41.2h-16.8v-41.2c-12-.1-33.1 0-50.1 5.7 0 0 .5-6.7.5-14.4 0-7.8-.5-14.4-.5-14.4 18.5 6.2 39.4 5.8 50 5.6v-25.9c-9.7 0-23.7.4-39.6 5.7 0 0 .5-6.6.5-14.4 0-7.7-.5-14.4-.5-14.4 15.9 5.3 29.9 5.8 39.6 5.7-.5-16.4-5.3-37-5.3-37s9.9.7 13.8.7c4 0 13.8-.7 13.8-.7s-4.8 20.6-5.3 37c9.7.1 23.7-.4 39.6-5.7 0 0-.5 6.7-.5 14.4 0 7.8.5 14.4.5 14.4a119 119 0 0 0-39.7-5.7v26z" ] []
        , Svg.path [ SvgAttributes.fill "#0b4ea2", SvgAttributes.d "M233 263.3c-19.9 0-30.5 27.5-30.5 27.5s-6-13-22.2-13c-11 0-19 9.7-24.2 18.8 20 31.7 51.9 51.3 76.9 63.4 25-12 57-31.7 76.9-63.4-5.2-9-13.2-18.8-24.2-18.8-16.2 0-22.2 13-22.2 13S253 263.3 233 263.3z" ] []
        ]


{-| -}
iceland : Html msg
iceland =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#a)"
            , SvgAttributes.clipPath "url(#b)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#d)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 13.5H10.5V19H21zM10.5 5v5.5H21V5zm-3 5.5V5H3v5.5zm0 3H3V19h4.5z"
                    , SvgAttributes.fill "#0e4cb5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 10.5V5h1v6.5H3v-1zm-4.5 2v1h4.5V19h1v-6.5zM9.5 19h1v-5.5H21v-1H9.5zM21 11.5v-1H10.5V5h-1v6.5z"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 5v6.5H3v1h5.5V19h1v-6.5H21v-1H9.5V5z"
                    , SvgAttributes.fill "#eb363a"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "b"
                ]
                [ Svg.path
                    [ SvgAttributes.fill "#fff"
                    , SvgAttributes.d "M0 0h24v24H0z"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "d"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#fff"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "a"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "2"
                , SvgAttributes.width "26"
                , SvgAttributes.height "22"
                , SvgAttributes.filterUnits "userSpaceOnUse"
                , SvgAttributes.colorInterpolationFilters "sRGB"
                ]
                [ Svg.feFlood
                    [ SvgAttributes.floodOpacity "0"
                    , SvgAttributes.result "BackgroundImageFix"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_43"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                    , SvgAttributes.result "hardAlpha"
                    ]
                    []
                , Svg.feOffset
                    [ SvgAttributes.dy "1"
                    ]
                    []
                , Svg.feGaussianBlur
                    [ SvgAttributes.stdDeviation "2"
                    ]
                    []
                , Svg.feComposite
                    [ SvgAttributes.in2 "hardAlpha"
                    , SvgAttributes.operator "out"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in2 "effect1_dropShadow_1726_43"
                    , SvgAttributes.result "effect2_dropShadow_1726_43"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_43"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            ]
        ]
