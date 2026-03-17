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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1726_39)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1726_39)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 3V8.5H3V11.5H7.5V17H10.5V11.5H21V8.5H10.5V3H7.5Z"
                    , SvgAttributes.fill "#FFCB00"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "#005293"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "#005293"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "#005293"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "#005293"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1726_39"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_39"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1726_39"
                    , SvgAttributes.result "effect2_dropShadow_1726_39"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_39"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1726_39"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1675_11)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1675_11)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 3V8.5H3V11.5H7.5V17H10.5V11.5H21V8.5H10.5V3H7.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "#EF264D"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "#EF264D"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "#EF264D"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "#EF264D"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1675_11"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1675_11"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1675_11"
                    , SvgAttributes.result "effect2_dropShadow_1675_11"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1675_11"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1675_11"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_51)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_51)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "#F14247"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "#F14247"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "#F14247"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "#F14247"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 8.5V3H8.5V9.5H3V8.5H7.5ZM3 10.5V11.5H7.5V17H8.5V10.5H3ZM9.5 17H10.5V11.5H21V10.5H9.5V17ZM21 9.5V8.5H10.5V3H9.5V9.5H21Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 3V9.5H3V10.5H8.5V17H9.5V10.5H21V9.5H9.5V3H8.5Z"
                    , SvgAttributes.fill "#0A3A85"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_51"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_51"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_51"
                    , SvgAttributes.result "effect2_dropShadow_1674_51"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_51"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_51"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1726_17)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1726_17)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M7.5 3V8.5H3V11.5H7.5V17H10.5V11.5H21V8.5H10.5V3H7.5Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1726_17"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_17"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1726_17"
                    , SvgAttributes.result "effect2_dropShadow_1726_17"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_17"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1726_17"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1726_32)" ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0)" ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "10"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "7"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M5 10H15C15 7.23858 12.7614 5 10 5C7.23858 5 5 7.23858 5 10Z"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10 15C12.7614 15 15 12.7614 15 10H5C5 12.7614 7.23858 15 10 15Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0" ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "filter0_dd_1726_32"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_32"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1726_32"
                    , SvgAttributes.result "effect2_dropShadow_1726_32"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_32"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1726_23)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1726_23)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 8.5V3H8.5V9.5H3V8.5H7.5ZM3 10.5V11.5H7.5V17H8.5V10.5H3ZM9.5 17H10.5V11.5H21V10.5H9.5V17ZM21 9.5V8.5H10.5V3H9.5V9.5H21Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 3V9.5H3V10.5H8.5V17H9.5V10.5H21V9.5H9.5V3H8.5Z"
                    , SvgAttributes.fill "#EB363A"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1726_23"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1726_23"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1726_23"
                    , SvgAttributes.result "effect2_dropShadow_1726_23"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1726_23"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1726_23"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_6)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_6)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "#0A17A7"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 3L3 17M21 17L3 3"
                    , SvgAttributes.stroke "white"
                    , SvgAttributes.strokeWidth "2"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 3.5L12 10.5"
                    , SvgAttributes.stroke "#DB1F35"
                    , SvgAttributes.strokeWidth "0.5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M21 16.5L12 9.5"
                    , SvgAttributes.stroke "#DB1F35"
                    , SvgAttributes.strokeWidth "0.5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M3 3.5L12 10.5"
                    , SvgAttributes.stroke "#DB1F35"
                    , SvgAttributes.strokeWidth "0.5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M3 16.5L12 9.5"
                    , SvgAttributes.stroke "#DB1F35"
                    , SvgAttributes.strokeWidth "0.5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M3 12H10V17L14 17V12L21 12V8L14 8V3H10V8L3 8V12Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M3 11H11V17L13 17V11L21 11V9L13 9V3H11V9L3 9V11Z"
                    , SvgAttributes.fill "#DB1F35"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_6"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_6"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_6"
                    , SvgAttributes.result "effect2_dropShadow_1674_6"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_6"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_6"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_15)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_15)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "12.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "#FFDA44"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "7.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "5"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "black"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_15"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_15"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_15"
                    , SvgAttributes.result "effect2_dropShadow_1674_15"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_15"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_15"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_25)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_25)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "15"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "6"
                    , SvgAttributes.height "14"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "9"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "6"
                    , SvgAttributes.height "14"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "6"
                    , SvgAttributes.height "14"
                    , SvgAttributes.fill "#6DA544"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_25"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_25"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_25"
                    , SvgAttributes.result "effect2_dropShadow_1674_25"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_25"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_25"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_20)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_20)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "13"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "7"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "6"
                    , SvgAttributes.fill "#FFDA44"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_20"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_20"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_20"
                    , SvgAttributes.result "effect2_dropShadow_1674_20"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_20"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_20"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1699_14)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1699_14)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "12.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "7.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "5"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1699_14"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1699_14"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1699_14"
                    , SvgAttributes.result "effect2_dropShadow_1699_14"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1699_14"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1699_14"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 3.5) ]
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1758_44)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1758_44)"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "12.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "black"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "7.5"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "5"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "4.5"
                    , SvgAttributes.fill "#5DA8F1"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1758_44"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1758_44"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1758_44"
                    , SvgAttributes.result "effect2_dropShadow_1758_44"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1758_44"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1758_44"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
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
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 3.5) ]
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1789_17)" ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0)" ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "10"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "7"
                    , SvgAttributes.fill "#D80027"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0" ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    ]
                    []
                ]
            , Svg.filter
                [ SvgAttributes.id "filter0_dd_1789_17"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1789_17"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1789_17"
                    , SvgAttributes.result "effect2_dropShadow_1789_17"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1789_17"
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
        , HtmlAttributes.css [ Css.borderRadius (Css.px 2), Css.margin2 (Css.px 0) (Css.px 3.5) ]
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
        , SvgAttributes.height "22"
        , SvgAttributes.viewBox "0 0 24 22"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.filter "url(#filter0_dd_1674_68)"
            ]
            [ Svg.g
                [ SvgAttributes.clipPath "url(#clip0_1674_68)"
                ]
                [ Svg.path
                    [ SvgAttributes.d "M21 11.5H10.5V17H21V11.5Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M10.5 3V8.5H21V3H10.5Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 8.5V3H3V8.5H7.5Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M7.5 11.5H3V17H7.5V11.5Z"
                    , SvgAttributes.fill "#0E4CB5"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.fillRule "evenodd"
                    , SvgAttributes.clipRule "evenodd"
                    , SvgAttributes.d "M7.5 8.5V3H8.5V9.5H3V8.5H7.5ZM3 10.5V11.5H7.5V17H8.5V10.5H3ZM9.5 17H10.5V11.5H21V10.5H9.5V17ZM21 9.5V8.5H10.5V3H9.5V9.5H21Z"
                    , SvgAttributes.fill "white"
                    ]
                    []
                , Svg.path
                    [ SvgAttributes.d "M8.5 3V9.5H3V10.5H8.5V17H9.5V10.5H21V9.5H9.5V3H8.5Z"
                    , SvgAttributes.fill "#EB363A"
                    ]
                    []
                ]
            ]
        , Svg.defs []
            [ Svg.filter
                [ SvgAttributes.id "filter0_dd_1674_68"
                , SvgAttributes.x "-1"
                , SvgAttributes.y "0"
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
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "BackgroundImageFix"
                    , SvgAttributes.result "effect1_dropShadow_1674_68"
                    ]
                    []
                , Svg.feColorMatrix
                    [ SvgAttributes.in_ "SourceAlpha"
                    , SvgAttributes.type_ "matrix"
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
                    [ SvgAttributes.type_ "matrix"
                    , SvgAttributes.values "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in2 "effect1_dropShadow_1674_68"
                    , SvgAttributes.result "effect2_dropShadow_1674_68"
                    ]
                    []
                , Svg.feBlend
                    [ SvgAttributes.mode "normal"
                    , SvgAttributes.in_ "SourceGraphic"
                    , SvgAttributes.in2 "effect2_dropShadow_1674_68"
                    , SvgAttributes.result "shape"
                    ]
                    []
                ]
            , Svg.clipPath
                [ SvgAttributes.id "clip0_1674_68"
                ]
                [ Svg.rect
                    [ SvgAttributes.x "3"
                    , SvgAttributes.y "3"
                    , SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        ]
