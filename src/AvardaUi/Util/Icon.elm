-- TODO: `Util.Icon` will not be an Util but a separate Ui file


module AvardaUi.Util.Icon exposing (arrowDown, arrowUp, checkMark, denmarkFlag, faroeIslandsFlag, finlandFlag, greenlandFlag, mockIconView, norwayFlag, swedenFlag)

import Css
import Html.Styled exposing (Html)
import Html.Styled.Attributes as HtmlAttributes
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttributes


mockIconView : Html msg
mockIconView =
    Svg.svg
        [ SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.path
            [ SvgAttributes.fillRule "evenodd"
            , SvgAttributes.clipRule "evenodd"
            , SvgAttributes.d "M17.6177 4.96811C16.078 3.73648 14.125 3 12 3C9.87499 3 7.92198 3.73647 6.38231 4.9681L12 10.5858L17.6177 4.96811ZM19.039 3.54674C17.1315 1.95663 14.6775 1 12 1C9.3225 1 6.86844 1.95662 4.96094 3.54673L4.22182 2.8076C3.83129 2.41708 3.19813 2.41708 2.8076 2.8076C2.41708 3.19813 2.41708 3.83129 2.8076 4.22182L3.54673 4.96094C1.95662 6.86844 1 9.3225 1 12C1 14.6775 1.95663 17.1315 3.54674 19.039L2.80762 19.7782L2.73857 19.8541C2.41839 20.2469 2.44157 20.8263 2.80762 21.1924C3.17367 21.5584 3.7531 21.5816 4.14587 21.2614L4.22183 21.1924L4.96095 20.4533C6.86844 22.0434 9.3225 23 12 23C14.6775 23 17.1315 22.0434 19.039 20.4533L19.7782 21.1924L19.8541 21.2614C20.2469 21.5816 20.8263 21.5584 21.1924 21.1924C21.5584 20.8263 21.5816 20.2469 21.2614 19.8541L21.1924 19.7782L20.4533 19.039C22.0434 17.1315 23 14.6775 23 12C23 9.32251 22.0434 6.86844 20.4533 4.96095L21.1924 4.22182C21.5829 3.83129 21.5829 3.19813 21.1924 2.8076C20.8019 2.41708 20.1687 2.41708 19.7782 2.8076L19.039 3.54674ZM19.0319 6.38232L13.4142 12L19.0319 17.6177C20.2635 16.078 21 14.125 21 12C21 9.87499 20.2635 7.92199 19.0319 6.38232ZM10.5858 12L4.9681 6.38231C3.73647 7.92198 3 9.87498 3 12C3 14.125 3.73648 16.078 4.96811 17.6177L10.5858 12ZM6.38232 19.0319L12 13.4142L17.6177 19.0319C16.078 20.2635 14.125 21 12 21C9.87499 21 7.92199 20.2635 6.38232 19.0319Z"
            , SvgAttributes.fill "currentColor"
            ]
            []
        ]


swedenFlag : Html msg
swedenFlag =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 18 14"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.clipPath "url(#clip0_1184_32)"
            ]
            [ Svg.path
                [ SvgAttributes.d "M4.5 0V5.5H0V8.5H4.5V14H7.5V8.5H18V5.5H7.5V0H4.5Z"
                , SvgAttributes.fill "#FFCB00"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M18 8.5H7.5V14H18V8.5Z"
                , SvgAttributes.fill "#005293"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M7.5 0V5.5H18V0H7.5Z"
                , SvgAttributes.fill "#005293"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 5.5V0H0V5.5H4.5Z"
                , SvgAttributes.fill "#005293"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 8.5H0V14H4.5V8.5Z"
                , SvgAttributes.fill "#005293"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0_1184_32"
                ]
                [ Svg.rect
                    [ SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        ]


denmarkFlag : Html msg
denmarkFlag =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 18 14"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.clipPath "url(#clip0_3836_39958)"
            ]
            [ Svg.path
                [ SvgAttributes.d "M4.5 0V5.5H0V8.5H4.5V14H7.5V8.5H18V5.5H7.5V0H4.5Z"
                , SvgAttributes.fill "white"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M18 8.5H7.5V14H18V8.5Z"
                , SvgAttributes.fill "#C51E22"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M7.5 0V5.5H18V0H7.5Z"
                , SvgAttributes.fill "#C51E22"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 5.5V0H0V5.5H4.5Z"
                , SvgAttributes.fill "#C51E22"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 8.5H0V14H4.5V8.5Z"
                , SvgAttributes.fill "#C51E22"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0_3836_39958"
                ]
                [ Svg.rect
                    [ SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        ]


norwayFlag : Html msg
norwayFlag =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 18 14"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.clipPath "url(#clip0_4082_39355)"
            ]
            [ Svg.path
                [ SvgAttributes.d "M18 8.5H7.5V14H18V8.5Z"
                , SvgAttributes.fill "#D12D23"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M7.5 0V5.5H18V0H7.5Z"
                , SvgAttributes.fill "#D12D23"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 5.5V0H0V5.5H4.5Z"
                , SvgAttributes.fill "#D12D23"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 8.5H0V14H4.5V8.5Z"
                , SvgAttributes.fill "#D12D23"
                ]
                []
            , Svg.path
                [ SvgAttributes.fillRule "evenodd"
                , SvgAttributes.clipRule "evenodd"
                , SvgAttributes.d "M4.5 5.5V0H5V6H0V5.5H4.5ZM0 8V8.5H4.5V14H5V8H0ZM7 14H7.5V8.5H18V8H7V14ZM7 0V6H18V5.5H7.5V0H7Z"
                , SvgAttributes.fill "white"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M18 6H7V0H5V6H0V8H5V14H7V8H18V6Z"
                , SvgAttributes.fill "#012451"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0_4082_39355"
                ]
                [ Svg.rect
                    [ SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        ]


finlandFlag : Html msg
finlandFlag =
    Svg.svg
        [ SvgAttributes.width "18"
        , SvgAttributes.height "14"
        , SvgAttributes.viewBox "0 0 18 14"
        , SvgAttributes.fill "none"
        ]
        [ Svg.g
            [ SvgAttributes.clipPath "url(#clip0_3836_39964)"
            ]
            [ Svg.path
                [ SvgAttributes.d "M4.5 0V5.5H0V8.5H4.5V14H7.5V8.5H18V5.5H7.5V0H4.5Z"
                , SvgAttributes.fill "#005293"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M18 8.5H7.5V14H18V8.5Z"
                , SvgAttributes.fill "white"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M7.5 0V5.5H18V0H7.5Z"
                , SvgAttributes.fill "white"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 5.5V0H0V5.5H4.5Z"
                , SvgAttributes.fill "white"
                ]
                []
            , Svg.path
                [ SvgAttributes.d "M4.5 8.5H0V14H4.5V8.5Z"
                , SvgAttributes.fill "white"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttributes.id "clip0_3836_39964"
                ]
                [ Svg.rect
                    [ SvgAttributes.width "18"
                    , SvgAttributes.height "14"
                    , SvgAttributes.rx "2"
                    , SvgAttributes.fill "white"
                    ]
                    []
                ]
            ]
        ]


greenlandFlag : Html msg
greenlandFlag =
    Svg.svg [ SvgAttributes.viewBox "0 0 18 12", SvgAttributes.width "16", SvgAttributes.height "11" ]
        [ Svg.path [ SvgAttributes.fill "#fff", SvgAttributes.d "M0 0h18v12H0z" ] []
        , Svg.path [ SvgAttributes.fill "#d00c33", SvgAttributes.d "M0 6h18v6H0zm3 0a4 4 0 0 0 8 0 4 4 0 0 0-8 0" ] []
        ]


faroeIslandsFlag : Html msg
faroeIslandsFlag =
    Svg.svg [ SvgAttributes.viewBox "0 0 22 16", SvgAttributes.width "16", SvgAttributes.height "11" ]
        [ Svg.path [ SvgAttributes.fill "#FFF", SvgAttributes.d "M0 0h22v16H0z" ] []
        , Svg.g [ SvgAttributes.fill "#0065BD" ]
            [ Svg.path [ SvgAttributes.d "M6 0h4v16H6z" ] []
            , Svg.path [ SvgAttributes.d "M0 6h22v4H0z" ] []
            ]
        , Svg.g [ SvgAttributes.fill "#ED2939" ]
            [ Svg.path [ SvgAttributes.d "M7 0h2v16H7z" ] []
            , Svg.path [ SvgAttributes.d "M0 7h22v2H0z" ] []
            ]
        ]


arrowDown : Html msg
arrowDown =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        , HtmlAttributes.css [ Css.flexShrink (Css.int 0) ]
        ]
        [ Svg.path
            [ SvgAttributes.d "M6 9L12 15L18 9"
            , SvgAttributes.stroke "black"
            , SvgAttributes.strokeWidth "2"
            , SvgAttributes.strokeLinecap "round"
            , SvgAttributes.strokeLinejoin "round"
            ]
            []
        ]


arrowUp : Html msg
arrowUp =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        , HtmlAttributes.css [ Css.flexShrink (Css.int 0) ]
        ]
        [ Svg.path
            [ SvgAttributes.d "M6 15L12 9L18 15"
            , SvgAttributes.stroke "black"
            , SvgAttributes.strokeWidth "2"
            , SvgAttributes.strokeLinecap "round"
            , SvgAttributes.strokeLinejoin "round"
            ]
            []
        ]


checkMark : Html msg
checkMark =
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "0 0 24 24"
        , SvgAttributes.fill "none"
        ]
        [ Svg.path
            [ SvgAttributes.d "M5 12.9041L8.38885 16.2929C8.77937 16.6834 9.41253 16.6834 9.80306 16.2929L18.6531 7.4428"
            , SvgAttributes.stroke "black"
            , SvgAttributes.strokeWidth "2"
            , SvgAttributes.strokeLinecap "round"
            ]
            []
        ]
