module Ui.Button exposing (newPrimary, newSecondary, view, withBaseStyles, withHoverStyles, withIsDisabled, withLeftChild, withMsgTypeLink, withMsgTypeOnClick, withMsgTypeSubmit, withRightChild, withSizeSmall, withSizeXSmall)

import Css
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



-- TODO: Button Tertiary?


type Variant
    = Primary
    | Secondary


type Button msgTypeState msg
    = Settings
        { label : String
        , isDisabled : Bool
        , size : Size
        , styleVariant : Variant
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , baseStyles : List Css.Style
        , hoverStyles : List Css.Style
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
        , baseStyles = []
        , hoverStyles = []
        , msgType = Submit
        }



-- Builders


newPrimary : InitSettings -> Button MsgTypeUnset msg
newPrimary =
    initSettings Primary


newSecondary : InitSettings -> Button MsgTypeUnset msg
newSecondary =
    initSettings Secondary


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


withSizeXSmall : Button msgTypeState msg -> Button msgTypeState msg
withSizeXSmall (Settings model) =
    Settings { model | size = XSmall }


withBaseStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withBaseStyles styles (Settings model) =
    Settings { model | baseStyles = styles }


withHoverStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withHoverStyles styles (Settings model) =
    Settings { model | hoverStyles = styles }


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
view (Settings { label, isDisabled, leftChild, rightChild, hoverStyles, baseStyles, size, styleVariant, msgType }) =
    let
        styles =
            baseButtonStyles
                ++ stylesBasedOnSize size
                ++ stylesBasedOnVariant styleVariant
                ++ baseStyles
                ++ hoverStyles
    in
    msgTypeToElement msgType
        ([ Attributes.css styles, Attributes.disabled isDisabled ] ++ msgTypeToAttributes msgType)
        [ iconView leftChild, Html.text label, iconView rightChild ]


iconView : Maybe (Html msg) -> Html msg
iconView =
    Maybe.map identity >> Maybe.withDefault (Html.text "")



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
    , Css.borderWidth Css.zero
    ]


stylesBasedOnSize : Size -> List Css.Style
stylesBasedOnSize size =
    case size of
        Default ->
            [ Css.property "gap" "8px"
            , Css.padding2 (Css.px 12) (Css.px 20)
            , Css.fontSize (Css.px 16)
            , Css.letterSpacing (Css.px -0.272)
            , Css.lineHeight (Css.px 20)
            ]

        Small ->
            [ Css.property "gap" "4px"
            , Css.padding2 (Css.px 8) (Css.px 16)
            , Css.fontSize (Css.px 14)
            , Css.letterSpacing (Css.px -0.28)
            , Css.lineHeight (Css.px 18)
            ]

        XSmall ->
            [ Css.padding2 (Css.px 4) (Css.px 12)
            , Css.fontSize (Css.px 14)
            , Css.letterSpacing (Css.px -0.28)
            , Css.lineHeight (Css.px 18)
            ]


stylesBasedOnVariant : Variant -> List Css.Style
stylesBasedOnVariant variant =
    case variant of
        Primary ->
            [ Css.backgroundColor (Css.hex "#000000")
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
            , Css.property "border" "2px solid #000000"
            , Css.hover [ Css.borderColor (Css.hex "#141414") ]
            , Css.active [ Css.borderColor (Css.hex "#262626") ]
            , Css.disabled
                [ Css.borderColor (Css.hex "#CCCCCC")
                , Css.color (Css.hex "#767676")
                , Css.cursor Css.notAllowed
                ]
            ]



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
            [ Attributes.href url
            , Attributes.css
                [ Css.textDecoration Css.none
                , Css.textAlign Css.center
                ]
            ]
                ++ additionalAttributes
