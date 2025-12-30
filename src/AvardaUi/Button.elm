module AvardaUi.Button exposing
    ( new, view
    , Button
    , MsgTypeSet, MsgTypeUnset
    , Variant(..)
    , withVariant, withLeftChild, withRightChild, withIsDisabled
    , withSizeLarge, withSizeMedium, withSizeSmall
    , withCapitalizedLabel, withBorderRadius, withBaseStyles, withHoverStyles, withActiveStyles, withAttributes
    , withLink, withOnClick, withSubmit
    )

{-| This module provides a styled button component with optional left/right icon. It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withIsDisabled`](#withIsDisabled) or [`withLeftChild`](#withLeftChild).
3.  Finish with [`view`](#view) to render it.


# Creating an Button

@docs new, view


# Button

@docs Button


# MsgType

@docs MsgTypeSet, MsgTypeUnset

#Variant

@docs Variant


# Configuration

@docs withVariant, withLeftChild, withRightChild, withIsDisabled
@docs withSizeLarge, withSizeMedium, withSizeSmall
@docs withCapitalizedLabel, withBorderRadius, withBaseStyles, withHoverStyles, withActiveStyles, withAttributes


## Button action configuration

By default, `submit` is used as the button action. You can change this behaviour by using either `withLink` or `withOnClick`.

@docs withLink, withOnClick, withSubmit

-}

import AvardaUi.Theme.Colors as Colors
import Css
import Css.Global
import Css.Transitions
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events


{-| MsgType which can be used for type annotations when defining helpers in your code.
-}
type MsgTypeSet
    = MsgTypeSet


{-| MsgType which can be used for type annotations when defining helpers in your code.
-}
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


{-| Button type which can be used for type annotations when defining helpers in your code.
-}
type Button msgTypeState msg
    = Settings
        { label : String
        , isDisabled : Bool
        , size : Size
        , variant : Variant
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , additionalBaseStyles : List Css.Style
        , maybeHoverStylesOverwrite : Maybe (List Css.Style)
        , maybeActiveStylesOverwrite : Maybe (List Css.Style)
        , additionalAttributes : List (Attribute msg)
        , msgType : MsgType msg
        , isLabelCapitalized : Bool
        , maybeBorderRadius : Maybe Float
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
        , maybeHoverStylesOverwrite = Nothing
        , maybeActiveStylesOverwrite = Nothing
        , additionalAttributes = []
        , msgType = Submit
        , isLabelCapitalized = False
        , maybeBorderRadius = Nothing
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


{-| Add additional base styles.
-}
withBaseStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withBaseStyles styles (Settings model) =
    Settings { model | additionalBaseStyles = model.additionalBaseStyles ++ styles }


{-| Overwrite hover styles.
-}
withHoverStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withHoverStyles styles (Settings model) =
    Settings { model | maybeHoverStylesOverwrite = Just styles }


{-| Overwrite active styles.
-}
withActiveStyles : List Css.Style -> Button msgTypeState msg -> Button msgTypeState msg
withActiveStyles styles (Settings model) =
    Settings { model | maybeActiveStylesOverwrite = Just styles }


{-| Add additional attributes.
-}
withAttributes : List (Attribute msg) -> Button msgTypeState msg -> Button msgTypeState msg
withAttributes attributes (Settings model) =
    Settings { model | additionalAttributes = attributes }


{-| Transfer the `<button>` into `<a>` tag that looks like a button.
You have to specify a `url` that will be passed into `href` attribute and additional `attributes` list, e.g. `target` or `rel`.

    AvardaUi.Button.new { label = "Link" }
        |> AvardaUi.Button.withLink
            { url = "https://google.com"
            , attributes =
                [ Attributes.target "_blank"
                , Attributes.rel "noopener noreferrer"
                ]
            }
        |> AvardaUi.Button.view

-}
withLink : { url : String, attributes : List (Attribute msg) } -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withLink { url, attributes } (Settings model) =
    Settings { model | msgType = Link url attributes }


{-| `<button>` with onClick handler.
-}
withOnClick : msg -> Button MsgTypeUnset msg -> Button MsgTypeSet msg
withOnClick msg (Settings model) =
    Settings { model | msgType = OnClick msg }


{-| `<button>` with `type = "submit"`.
This the default button type.
-}
withSubmit : Button MsgTypeUnset msg -> Button MsgTypeSet msg
withSubmit (Settings model) =
    Settings { model | msgType = Submit }


{-| Change button variant ([`Variant`](#Variant)). `Primary` is set by default.
-}
withVariant : Variant -> Button msgTypeState msg -> Button msgTypeState msg
withVariant variant (Settings model) =
    Settings { model | variant = variant }


{-| Capitalize the label.
-}
withCapitalizedLabel : Bool -> Button msgTypeState msg -> Button msgTypeState msg
withCapitalizedLabel isLabelCapitalized (Settings model) =
    Settings { model | isLabelCapitalized = isLabelCapitalized }


{-| Explicitly set border-radius.
**This will override border-radius set in [`withBaseStyles`](#withBaseStyles).**
-}
withBorderRadius : Float -> Button msgTypeState msg -> Button msgTypeState msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | maybeBorderRadius = Just borderRadius }


{-| Render the Button as HTML.

Always call this after you've built up the button with `new` and chained settings.

    AvardaUi.Button.new {...}
        |> AvardaUi.Button.withIsRequired True
        |> AvardaUi.Select.view

-}
view : Button msgTypeState msg -> Html msg
view ((Settings { label, isDisabled, leftChild, rightChild, additionalBaseStyles, additionalAttributes, size, msgType, maybeBorderRadius, isLabelCapitalized }) as buttonSettings) =
    let
        maybeBorderRadiusStyle =
            maybeBorderRadius
                |> Maybe.map (Css.px >> Css.borderRadius)
                |> Maybe.withDefault (Css.batch [])

        styles =
            Css.Global.descendants [ Css.Global.svg [ iconHeightBasedOnSize size ] ]
                :: baseButtonStyles isLabelCapitalized
                ++ stylesBasedOnSizeAndVariant buttonSettings
                ++ stylesBasedOnMsgType msgType
                ++ additionalBaseStyles
                -- Explicitly override border-radius
                ++ [ maybeBorderRadiusStyle ]

        --
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
    Maybe.withDefault (Html.text "")



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


baseButtonStyles : Bool -> List Css.Style
baseButtonStyles isLabelCapitalized =
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
    , Css.width (Css.pct 100)
    , if isLabelCapitalized then
        Css.textTransform Css.uppercase

      else
        Css.textTransform Css.none
    ]


stylesBasedOnSizeAndVariant : Button msgTypeState msg -> List Css.Style
stylesBasedOnSizeAndVariant (Settings { size, variant, isDisabled, maybeHoverStylesOverwrite, maybeActiveStylesOverwrite }) =
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

        hoverStyles styles =
            Maybe.withDefault styles maybeHoverStylesOverwrite

        activeStyles styles =
            Maybe.withDefault styles maybeActiveStylesOverwrite

        variantStyles =
            case variant of
                Primary ->
                    [ Css.backgroundColor Colors.grayscale12
                    , Css.borderWidth Css.zero
                    , Css.color Colors.white
                    , Css.outlineOffset (Css.px 2)
                    ]
                        ++ hoverAndActiveStyles
                            [ Css.hover (hoverStyles [ Css.backgroundColor Colors.black ])
                            , Css.active (activeStyles [ Css.backgroundColor Colors.grayscale11 ])
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
                            [ Css.hover (hoverStyles [ Css.backgroundColor Colors.grayscale3 ])
                            , Css.active (activeStyles [ Css.backgroundColor Colors.grayscale4 ])
                            ]

                Tertiary ->
                    [ Css.backgroundColor Colors.transparent
                    , Css.color Colors.grayscale12
                    , Css.borderWidth Css.zero
                    ]
                        ++ hoverAndActiveStyles
                            [ Css.hover (hoverStyles [ Css.backgroundColor Colors.grayscale3 ])
                            , Css.active (activeStyles [ Css.backgroundColor Colors.grayscale4 ])
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
