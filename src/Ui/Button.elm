module Ui.Button exposing (newPrimary, newSecondary, newTertiary, view, withBaseStyles, withHoverStyles, withIsDisabled, withLeftChild, withMsgTypeLink, withMsgTypeOnClick, withMsgTypeSubmit, withRightChild, withSizeSmall, withSizeXSmall)

import Css
import Css.Global
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events



-- Settings


type MsgTypeSet
    = MsgTypeSet


type MsgTypeUnset
    = MsgTypeUnset


type MsgType msg
    = OnClick msg
    | Link String (List (Attribute msg))
    | Submit


type Size
    = Default
    | Small
    | XSmall


type Variant
    = Primary
    | Secondary
    | Tertiary


type Button msgTypeState msg
    = Settings
        { label : String
        , isDisabled : Bool
        , size : Size
        , styleVariant : Variant
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , additionalBaseStyles : List Css.Style
        , additionalHoverStyles : List Css.Style
        , msgType : MsgType msg
        }


type alias InitSettings =
    { label : String }


initSettings : Variant -> InitSettings -> Button MsgTypeUnset msg
initSettings styleVariant { label } =
    Settings
        { label = label
        , isDisabled = False
        , size = Default
        , styleVariant = styleVariant
        , leftChild = Nothing
        , rightChild = Nothing
        , additionalBaseStyles = []
        , additionalHoverStyles = []
        , msgType = Submit
        }



-- Builders


newPrimary : InitSettings -> Button MsgTypeUnset msg
newPrimary =
    initSettings Primary


newSecondary : InitSettings -> Button MsgTypeUnset msg
newSecondary =
    initSettings Secondary


newTertiary : InitSettings -> Button MsgTypeUnset msg
newTertiary =
    initSettings Tertiary


withIsDisabled : Bool -> Button msgTypeState msg -> Button msgTypeState msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withLeftChild : Html msg -> Button msgTypeState msg -> Button msgTypeState msg
withLeftChild child (Settings model) =
    Settings { model | leftChild = Just child }


withRightChild : Html msg -> Button msgTypeState msg -> Button msgTypeState msg
withRightChild child (Settings model) =
    Settings { model | rightChild = Just child }


withSizeSmall : Button msgTypeState msg -> Button msgTypeState msg
withSizeSmall (Settings model) =
    Settings { model | size = Small }



-- TODO: When using withSizeXSmall, dont allow children


withSizeXSmall : Button msgTypeState msg -> Button msgTypeState msg
withSizeXSmall (Settings model) =
    Settings { model | size = XSmall }


withBaseStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withBaseStyles styles (Settings model) =
    Settings { model | additionalBaseStyles = styles }


withHoverStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withHoverStyles styles (Settings model) =
    Settings { model | additionalHoverStyles = styles }


withMsgTypeLink : { link : String, attributes : List (Attribute msg) } -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeLink { link, attributes } (Settings model) =
    Settings { model | msgType = Link link attributes }


withMsgTypeOnClick : msg -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeOnClick msg (Settings model) =
    Settings { model | msgType = OnClick msg }


withMsgTypeSubmit : Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeSubmit (Settings model) =
    Settings { model | msgType = Submit }


view : Button MsgTypeSet msg -> Html msg
view (Settings { label, isDisabled, leftChild, rightChild, additionalHoverStyles, additionalBaseStyles, size, styleVariant, msgType }) =
    let
        className =
            "avd-button"

        styles =
            baseButtonStyles
                ++ stylesBasedOnSizeAndVariant size styleVariant
                ++ stylesBasedOnMsgType msgType
                ++ additionalBaseStyles
                ++ additionalHoverStyles

        iconHeightGlobalStyle =
            Css.Global.global
                [ Css.Global.class className
                    [ Css.Global.descendants [ Css.Global.svg [ iconHeightBasedOnSize size ] ]
                    ]
                ]
    in
    msgTypeToElement msgType
        ([ Attributes.css styles, Attributes.disabled isDisabled, Attributes.class className ] ++ msgTypeToAttributes msgType)
        [ iconView leftChild
        , Html.text label
        , iconView rightChild
        , iconHeightGlobalStyle
        ]


iconView : Maybe (Html msg) -> Html msg
iconView =
    Maybe.map identity >> Maybe.withDefault (Html.text "")



-- TODO: This will / would require us to set only height in icons and compute the width automatically
-- NOTE: Achievable if using builder pattern with Svgs


iconHeightBasedOnSize : Size -> Css.Style
iconHeightBasedOnSize size =
    let
        heightStyle =
            Css.height << Css.px
    in
    case size of
        Default ->
            heightStyle 24

        Small ->
            heightStyle 20

        -- NOTE: By design, XSmall buttons shouldn't have an option to display icons
        XSmall ->
            heightStyle 0



-- Styles


baseButtonStyles : List Css.Style
baseButtonStyles =
    [ Css.cursor Css.pointer
    , Css.whiteSpace Css.normal
    , Css.fontFamily Css.inherit
    , Css.active [ Css.transform <| Css.scale 0.99 ]
    , Css.justifyContent Css.center
    , Css.alignItems Css.center
    , Css.display Css.inlineFlex
    , Css.borderRadius (Css.px 200)
    , Css.padding (Css.px 0)
    ]


stylesBasedOnSizeAndVariant : Size -> Variant -> List Css.Style
stylesBasedOnSizeAndVariant size variant =
    let
        secondaryButtonBorderWidth =
            2

        -- Reason behind this is that secondary button was bigger in size because of its border
        -- box-sizing: border-box didn't do anything so i went with this solution for now
        padding2_ p1 p2 =
            if variant == Secondary then
                Css.padding2 (Css.px <| p1 - secondaryButtonBorderWidth) (Css.px <| p2 - secondaryButtonBorderWidth)

            else
                Css.padding2 (Css.px p1) (Css.px p2)

        -- TODO: Extract values to Colors/Theme file
        variantStyles =
            case variant of
                Primary ->
                    [ Css.backgroundColor (Css.hex "#000000")
                    , Css.borderWidth Css.zero
                    , Css.color (Css.hex "#FFFFFF")
                    , Css.hover [ Css.backgroundColor (Css.hex "#141414") ]
                    , Css.active [ Css.backgroundColor (Css.hex "#262626") ]
                    , Css.disabled
                        [ Css.backgroundColor (Css.hex "#CCCCCC")
                        , Css.color (Css.hex "#767676")
                        , Css.cursor Css.notAllowed
                        ]
                    ]

                Secondary ->
                    [ Css.backgroundColor (Css.hex "#00000000")
                    , Css.color (Css.hex "#000000")
                    , Css.borderStyle Css.solid
                    , Css.borderColor (Css.hex "#000000")
                    , Css.borderWidth (Css.px secondaryButtonBorderWidth)
                    , Css.hover [ Css.borderColor (Css.hex "#141414") ]
                    , Css.active [ Css.borderColor (Css.hex "#262626") ]
                    , Css.disabled
                        [ Css.borderColor (Css.hex "#CCCCCC")
                        , Css.color (Css.hex "#767676")
                        , Css.cursor Css.notAllowed
                        ]
                    ]

                Tertiary ->
                    [ Css.backgroundColor (Css.hex "#00000000")
                    , Css.color (Css.hex "#000000")
                    , Css.borderWidth Css.zero
                    , Css.hover [ Css.backgroundColor (Css.hex "#F2F2F2") ]
                    , Css.active [ Css.backgroundColor (Css.hex "#00000000") ]
                    , Css.disabled
                        [ Css.backgroundColor (Css.hex "#00000000")
                        , Css.color (Css.hex "#767676")
                        , Css.cursor Css.notAllowed
                        ]
                    ]

        sizeStyles =
            case size of
                Default ->
                    [ Css.property "gap" "8px"
                    , padding2_ 12 20
                    , Css.fontSize (Css.px 16)
                    , Css.letterSpacing (Css.px -0.272)
                    , Css.lineHeight (Css.px 20)
                    ]

                Small ->
                    [ Css.property "gap" "6px"
                    , padding2_ 10 16
                    , Css.fontSize (Css.px 14)
                    , Css.letterSpacing (Css.px -0.28)
                    , Css.lineHeight (Css.px 18)
                    ]

                XSmall ->
                    [ padding2_ 7 12
                    , Css.fontSize (Css.px 14)
                    , Css.letterSpacing (Css.px -0.28)
                    , Css.lineHeight (Css.px 18)
                    ]
    in
    variantStyles ++ sizeStyles


stylesBasedOnMsgType : MsgType msg -> List Css.Style
stylesBasedOnMsgType msgType =
    case msgType of
        OnClick _ ->
            []

        Submit ->
            []

        Link _ _ ->
            [ Css.textDecoration Css.none, Css.textAlign Css.center ]



-- Helpers


msgTypeToElement : MsgType msg -> List (Attribute msg) -> List (Html msg) -> Html msg
msgTypeToElement msgType =
    case msgType of
        OnClick _ ->
            Html.button

        Link _ _ ->
            Html.a

        Submit ->
            Html.button


msgTypeToAttributes : MsgType msg -> List (Attribute msg)
msgTypeToAttributes msgType =
    case msgType of
        OnClick msg ->
            [ Attributes.type_ "button"
            , Events.onClick msg
            ]

        Submit ->
            [ Attributes.type_ "submit" ]

        -- TODO: Should we be able to disable Link?
        Link url additionalAttributes ->
            Attributes.href url :: additionalAttributes
