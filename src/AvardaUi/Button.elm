module AvardaUi.Button exposing
    ( new, view
    , Variant(..)
    , withVariant, withLeftChild, withRightChild, withIsDisabled
    , withSizeLarge, withSizeMedium, withSizeSmall
    , withBaseStyles, withHoverStyles, withAttributes
    , withMsgTypeLink, withMsgTypeOnClick, withMsgTypeSubmit
    )

{-| This module provides a styled button component with optional left/right icon. It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withIsDisabled`](#withIsDisabled) or [`withLeftChild`](#withLeftChild).
3.  Finish with [`view`](#view) to render it.


# Creating an Button

@docs new, view

#Variant

@docs Variant


# Configuration

@docs withVariant, withLeftChild, withRightChild, withIsDisabled
@docs withSizeLarge, withSizeMedium, withSizeSmall
@docs withBaseStyles, withHoverStyles, withAttributes
@docs withMsgTypeLink, withMsgTypeOnClick, withMsgTypeSubmit

-}

import AvardaUi.Theme.Colors as Colors
import Css
import Css.Global
import Css.Transitions
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events


type MsgTypeSet
    = MsgTypeSet


type MsgTypeUnset
    = MsgTypeUnset


type MsgType msg
    = OnClick msg
    | Link String (List (Attribute msg))
    | Submit


type Size
    = Large
    | Medium
    | Small


{-| Style variants of the button.
This is used with [`withVariant`](#withVariant)
-}
type Variant
    = Primary
    | Secondary
    | Tertiary


type Button msgTypeState msg
    = Settings
        { label : String
        , isDisabled : Bool
        , size : Size
        , variant : Variant
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , additionalBaseStyles : List Css.Style
        , additionalHoverStyles : List Css.Style
        , additionalAttributes : List (Attribute msg)
        , msgType : MsgType msg
        }


{-| Create a new Button component.

    AvardaUi.Button.new
        { label = "Click me" }

-}
new : { label : String } -> Button MsgTypeUnset msg
new { label } =
    Settings
        { label = label
        , isDisabled = False
        , size = Large
        , variant = Primary
        , leftChild = Nothing
        , rightChild = Nothing
        , additionalBaseStyles = []
        , additionalHoverStyles = []
        , additionalAttributes = []
        , msgType = Submit
        }


{-| Disable the button.
Visually dims and prevents user actions.
-}
withIsDisabled : Bool -> Button msgTypeState msg -> Button msgTypeState msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


{-| Add a left-side child element, preferably an icon.
-}
withLeftChild : Html msg -> Button msgTypeState msg -> Button msgTypeState msg
withLeftChild child (Settings model) =
    Settings { model | leftChild = Just child }


{-| Add a right-side child element, preferably an icon.
-}
withRightChild : Html msg -> Button msgTypeState msg -> Button msgTypeState msg
withRightChild child (Settings model) =
    Settings { model | rightChild = Just child }


{-| Change button sizing to `large` (default).
-}
withSizeLarge : Button msgTypeState msg -> Button msgTypeState msg
withSizeLarge (Settings model) =
    Settings { model | size = Large }


{-| Change button sizing to `medium`.
-}
withSizeMedium : Button msgTypeState msg -> Button msgTypeState msg
withSizeMedium (Settings model) =
    Settings { model | size = Medium }


{-| Change button sizing to `small`.
-}
withSizeSmall : Button msgTypeState msg -> Button msgTypeState msg
withSizeSmall (Settings model) =
    Settings { model | size = Small }


{-| Overwrite or add additional base styles.
-}
withBaseStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withBaseStyles styles (Settings model) =
    Settings { model | additionalBaseStyles = styles }


{-| Overwrite or add additional hover styles.
-}
withHoverStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withHoverStyles styles (Settings model) =
    Settings { model | additionalHoverStyles = styles }


{-| Add additional attributes.
-}
withAttributes : List (Attribute msg) -> Button msgTypeState msg -> Button msgTypeState msg
withAttributes attributes (Settings model) =
    Settings { model | additionalAttributes = attributes }


{-| Transfer the `<button>` into `<a>` tag that looks like a button.
You have to specify a `link` that will be passed into `href` attribute and additional `attributes` list, e.g. `target` or `rel`.

    AvardaUi.Button.new { label = "Link" }
        |> AvardaUi.Button.withMsgTypeLink
            { link = "https://google.com"
            , attributes =
                [ Attributes.target "_blank"
                , Attributes.rel "noopener noreferrer"
                ]
            }
        |> AvardaUi.Button.view

-}
withMsgTypeLink : { link : String, attributes : List (Attribute msg) } -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeLink { link, attributes } (Settings model) =
    Settings { model | msgType = Link link attributes }


{-| `<button>` with onClick handler.
-}
withMsgTypeOnClick : msg -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeOnClick msg (Settings model) =
    Settings { model | msgType = OnClick msg }


{-| `<button>` with `type = "submit"`.
This the default button type.
-}
withMsgTypeSubmit : Button MsgTypeUnset msg -> Button MsgTypeSet msg
withMsgTypeSubmit (Settings model) =
    Settings { model | msgType = Submit }


{-| Change button variant ([`Variant`](#Variant)). `Primary` is set by default.
-}
withVariant : Variant -> Button msgTypeState msg -> Button msgTypeState msg
withVariant variant (Settings model) =
    Settings { model | variant = variant }


{-| Render the Button as HTML.

Always call this after you've built up the button with `new` and chained settings.

    AvardaUi.Button.new {...}
        |> AvardaUi.Button.withIsRequired True
        |> AvardaUi.Select.view

-}
view : Button MsgTypeSet msg -> Html msg
view (Settings { label, isDisabled, leftChild, rightChild, additionalHoverStyles, additionalBaseStyles, additionalAttributes, size, variant, msgType }) =
    let
        styles =
            Css.Global.descendants [ Css.Global.svg [ iconHeightBasedOnSize size ] ]
                :: baseButtonStyles
                ++ stylesBasedOnSizeAndVariant size variant isDisabled
                ++ stylesBasedOnMsgType msgType
                ++ additionalBaseStyles
                ++ (if isDisabled then
                        []

                    else
                        [ Css.hover additionalHoverStyles ]
                   )
    in
    msgTypeToElement msgType
        ([ Attributes.css styles, Attributes.disabled isDisabled ]
            ++ msgTypeToAttributes msgType
            ++ additionalAttributes
        )
        [ iconView leftChild
        , Html.text label
        , iconView rightChild
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
        Large ->
            heightStyle 24

        Medium ->
            heightStyle 20

        Small ->
            heightStyle 16



-- Styles


baseButtonStyles : List Css.Style
baseButtonStyles =
    [ Css.cursor Css.pointer
    , Css.whiteSpace Css.normal
    , Css.fontFamily Css.inherit
    , Css.disabled
        [ Css.cursor Css.notAllowed
        , Css.opacity (Css.num 0.56)
        ]
    , Css.Transitions.transition [ Css.Transitions.backgroundColor 200 ]
    , Css.justifyContent Css.center
    , Css.alignItems Css.center
    , Css.display Css.inlineFlex
    , Css.borderRadius (Css.px 200)
    , Css.padding (Css.px 0)
    ]


stylesBasedOnSizeAndVariant : Size -> Variant -> Bool -> List Css.Style
stylesBasedOnSizeAndVariant size variant isDisabled =
    let
        secondaryButtonBorderWidth =
            2

        -- Reason behind this is that secondary button was bigger in size because of its border
        -- box-sizing: border-box didn't do anything so i went with this solution for now
        padding2_ p1 p2 =
            if variant == Secondary then
                Css.padding2 (Css.px (p1 - secondaryButtonBorderWidth)) (Css.px (p2 - secondaryButtonBorderWidth))

            else
                Css.padding2 (Css.px p1) (Css.px p2)

        hoverAndActiveStyles styles =
            if isDisabled then
                []

            else
                styles

        variantStyles =
            case variant of
                Primary ->
                    [ Css.backgroundColor Colors.grayscale12
                    , Css.borderWidth Css.zero
                    , Css.color Colors.white
                    , Css.outlineOffset (Css.px 2)
                    ]
                        ++ hoverAndActiveStyles
                            [ Css.hover [ Css.backgroundColor Colors.black ]
                            , Css.active [ Css.backgroundColor Colors.grayscale11 ]
                            ]

                Secondary ->
                    [ Css.backgroundColor Colors.transparent
                    , Css.color Colors.grayscale12
                    , Css.borderStyle Css.solid
                    , Css.borderColor Colors.grayscale12
                    , Css.borderWidth (Css.px secondaryButtonBorderWidth)
                    , Css.outlineOffset (Css.px 3)
                    ]
                        ++ hoverAndActiveStyles
                            [ Css.hover [ Css.backgroundColor Colors.grayscale3 ]
                            , Css.active [ Css.backgroundColor Colors.grayscale4 ]
                            ]

                Tertiary ->
                    [ Css.backgroundColor Colors.transparent
                    , Css.color Colors.grayscale12
                    , Css.borderWidth Css.zero
                    ]
                        ++ hoverAndActiveStyles
                            [ Css.hover [ Css.backgroundColor Colors.grayscale3 ]
                            , Css.active [ Css.backgroundColor Colors.grayscale4 ]
                            ]

        sizeStyles =
            case size of
                Large ->
                    [ Css.property "gap" "8px"
                    , padding2_ 12 20
                    , Css.fontSize (Css.px 16)
                    , Css.letterSpacing (Css.px -0.272)
                    , Css.lineHeight (Css.px 20)
                    ]

                Medium ->
                    [ Css.property "gap" "6px"
                    , padding2_ 10 16
                    , Css.fontSize (Css.px 14)
                    , Css.letterSpacing (Css.px -0.28)
                    , Css.lineHeight (Css.px 18)
                    ]

                Small ->
                    [ Css.property "gap" "4px"
                    , padding2_ 7 12
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
