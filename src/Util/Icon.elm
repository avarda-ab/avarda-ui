-- TODO: `Util.Icon` will not be an Util but a separate Ui file


module Util.Icon exposing (arrowDown, arrowUp, denmarkFlag, faroeIslandsFlag, finlandFlag, greenlandFlag, mockIconView, norwayFlag, radioButton, swedenFlag)

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


radioButton : Bool -> Html msg
radioButton isSelected =
    let
        ( outlineColor, fillColor ) =
            if isSelected then
                ( "#000", "#000" )

            else
                ( "#CCC", "#00000000" )
    in
    Svg.svg
        [ SvgAttributes.width "24"
        , SvgAttributes.height "24"
        , SvgAttributes.viewBox "1 1 22 22"
        ]
        [ Svg.path
            [ SvgAttributes.fillRule "evenodd"
            , SvgAttributes.clipRule "evenodd"
            , SvgAttributes.d "M1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92486 23 12C23 18.0751 18.0751 23 12 23C5.92486 23 1 18.0751 1 12ZM12 3C7.02943 3 3 7.02943 3 12C3 16.9705 7.02944 21 12 21C16.9705 21 21 16.9705 21 12C21 7.02944 16.9705 3 12 3Z"
            , SvgAttributes.fill outlineColor
            ]
            []
        , Svg.path
            [ SvgAttributes.fillRule "evenodd"
            , SvgAttributes.clipRule "evenodd"
            , SvgAttributes.d "M12 1.25C6.06294 1.25 1.25 6.06294 1.25 12C1.25 17.9371 6.06294 22.75 12 22.75C17.9371 22.75 22.75 17.9371 22.75 12C22.75 6.06294 17.9371 1.25 12 1.25ZM7.53044 11.9697C7.23755 11.6768 6.76268 11.6768 6.46978 11.9697C6.17689 12.2626 6.17689 12.7374 6.46978 13.0303L9.46978 16.0303C9.76268 16.3232 10.2376 16.3232 10.5304 16.0303L17.5304 9.03033C17.8233 8.73744 17.8233 8.26256 17.5304 7.96967C17.2375 7.67678 16.7627 7.67678 16.4698 7.96967L10.0001 14.4393L7.53044 11.9697Z"
            , SvgAttributes.fill fillColor
            ]
            []
        ]
