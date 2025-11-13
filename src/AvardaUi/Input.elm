module AvardaUi.Input exposing
    ( new, view
    , withPlaceholder, withIsRequired, withIsDisabled, withInputType, withMaxLength, withBorderRadius, withAutocomplete, withAttributes, withOnKeyDown, withMaybeError, withHint, withLeftChild, withRightChild, withFloatingLabelBackgroundColor
    )

{-| This component provides a styled input with support for floating labels, hints, error messages,
and optional left/right children. It uses the [builder pattern](https://sporto.github.io/elm-patterns/basic/builder-pattern.html):

1.  Start with [`new`](#new) to create a base input.
2.  Chain configuration functions like [`withPlaceholder`](#withPlaceholder) or [`withIsRequired`](#withIsRequired).
3.  Finish with [`view`](#view) to render it.


# Creating an Input

@docs new, view


# Configuration

@docs withPlaceholder, withIsRequired, withIsDisabled, withInputType, withMaxLength, withBorderRadius, withAutocomplete, withAttributes, withOnKeyDown, withMaybeError, withHint, withLeftChild, withRightChild, withFloatingLabelBackgroundColor

-}

import AvardaUi.Util.Accessibility as AccessibilityUtil
import AvardaUi.Util.KeyPress as KeyPressUtil
import Css
import Css.Global
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events


baseId : String
baseId =
    "avd-input-"


prependBaseId : String -> String
prependBaseId id =
    if String.contains "avd-suggestion_input-" id then
        id

    else
        baseId ++ id


inputId : String -> String
inputId id =
    prependBaseId id


labelId : String -> String
labelId id =
    inputId id ++ "-label"


inputWrapperId : String -> String
inputWrapperId id =
    inputId id ++ "-wrapper"


errorId : String -> String
errorId id =
    inputId id ++ "-error"


hintId : String -> String
hintId id =
    inputId id ++ "-hint"


type Input msg
    = Settings
        { id : String
        , value : String
        , msg : String -> msg
        , label : String
        , borderRadius : Float
        , inputType : String
        , placeholder : Maybe String
        , maxLength : Int
        , attributes : List (Attribute msg)
        , isDisabled : Bool
        , isRequired : Bool
        , leftChild : Maybe (Html msg)
        , rightChild : Maybe (Html msg)
        , hintText : Maybe String
        , autocomplete : Maybe String
        , maybeError : Maybe String
        , onKeyDown : List ( KeyPressUtil.KeyboardKey, msg )
        , floatingLabelBackgroundColor : Css.Color
        }


{-| Create a new input with required fields: `id`, `value`, `msg`, and `label`.

This gives you a base input that you can configure further with `withX` functions.

    AvardaUi.Input.new "username"
        { value = model.username
        , msg = InsertedUsername
        , label = "Username"
        }

-}
new : String -> { value : String, msg : String -> msg, label : String } -> Input msg
new id { value, msg, label } =
    let
        defaultInputMaxLength =
            524288

        defaultBorderRadius =
            8
    in
    Settings
        { id = id
        , value = value
        , msg = msg
        , label = label
        , borderRadius = defaultBorderRadius
        , inputType = "text"
        , placeholder = Nothing
        , maxLength = defaultInputMaxLength
        , attributes = []
        , isDisabled = False
        , isRequired = False
        , leftChild = Nothing
        , rightChild = Nothing
        , hintText = Nothing
        , autocomplete = Nothing
        , maybeError = Nothing
        , onKeyDown = []
        , floatingLabelBackgroundColor = Css.hex "#FFFFFF"
        }


{-| Show an error message and mark the input invalid.
**Replaces any active hint text.**
-}
withMaybeError : Maybe String -> Input msg -> Input msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


{-| Add a placeholder to the input.
-}
withPlaceholder : String -> Input msg -> Input msg
withPlaceholder placeholder (Settings model) =
    Settings { model | placeholder = Just placeholder }


{-| Add a left-side child element, e.g. an icon.
-}
withLeftChild : Html msg -> Input msg -> Input msg
withLeftChild leftChild (Settings model) =
    Settings { model | leftChild = Just leftChild }


{-| Add a right-side child element, e.g. a clear button.
-}
withRightChild : Html msg -> Input msg -> Input msg
withRightChild rightChild (Settings model) =
    Settings { model | rightChild = Just rightChild }


{-| Mark the input as required.
This adds a `*` to the label and sets `required=true`.
-}
withIsRequired : Bool -> Input msg -> Input msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


{-| Add a hint text below the input.
-}
withHint : String -> Input msg -> Input msg
withHint hintText (Settings model) =
    Settings { model | hintText = Just hintText }


{-| Change the input type (e.g. `"text"`, `"password"`, `"email"`).
-}
withInputType : String -> Input msg -> Input msg
withInputType inputType (Settings model) =
    Settings { model | inputType = inputType }


{-| Disable the input.
Visually dims and prevents typing.
-}
withIsDisabled : Bool -> Input msg -> Input msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


{-| Adjust the border radius of the input box.
-}
withBorderRadius : Float -> Input msg -> Input msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


{-| Limit the maximum number of characters.
-}
withMaxLength : Int -> Input msg -> Input msg
withMaxLength maxLength (Settings model) =
    Settings { model | maxLength = maxLength }


{-| Enable autocomplete with a given string like `"username"`. It is set to `"off"` by default.
-}
withAutocomplete : String -> Input msg -> Input msg
withAutocomplete autocomplete (Settings model) =
    Settings { model | autocomplete = Just autocomplete }


{-| Attach additional HTML attributes to the underlying `<input>` element.
For example `name` or `data-*` attributes.
-}
withAttributes : List (Attribute msg) -> Input msg -> Input msg
withAttributes attributes (Settings model) =
    Settings { model | attributes = attributes }


{-| Listen for key presses and map them to messages.
It uses the `KeyboardKey` type from `AvardaUi.Util.KeyPress` module.

    AvardaUi.Input.new "username" {...}
        |> AvardaUi.Input.withOnKeyDown [ ( KeyPressUtil.Enter, HandleSubmit ) ]

-}
withOnKeyDown : List ( KeyPressUtil.KeyboardKey, msg ) -> Input msg -> Input msg
withOnKeyDown onKeyDown (Settings model) =
    Settings { model | onKeyDown = onKeyDown }


{-| Sets the background color of the floating label.
This is useful when the color of the background behind the input is something else then `#FFFFFF`.
-}
withFloatingLabelBackgroundColor : Css.Color -> Input msg -> Input msg
withFloatingLabelBackgroundColor color (Settings model) =
    Settings { model | floatingLabelBackgroundColor = color }


{-| Render the configured input as HTML.

Always call this after you've built up the input with `new` and chained settings.

    AvardaUi.Input.new "username" {...}
        |> AvardaUi.Input.withPlaceholder "Enter username"
        |> AvardaUi.Input.withIsRequired True
        |> AvardaUi.Input.view

-}
view : Input msg -> Html msg
view ((Settings { leftChild, rightChild, borderRadius, id, isDisabled, hintText, maybeError }) as model) =
    let
        inputView_ =
            let
                invalidStyle_ =
                    if maybeError == Nothing then
                        Css.batch []

                    else
                        invalidStyle
            in
            if List.all ((==) Nothing) [ leftChild, rightChild ] then
                labelWithInputView model
                    [ Css.minHeight (Css.px 48)
                    , invalidStyle_
                    , disabledStyle isDisabled
                    , Css.padding (Css.px 16)
                    , Css.pseudoClass "focus-visible" [ defaultPlaceholderColor ]
                    , Css.height (Css.px 54)
                    ]

            else
                Html.div
                    [ Attributes.css
                        [ Css.displayFlex
                        , Css.height (Css.px 54)
                        , Css.pseudoClass "focus-within" [ defaultFocusOutline, invalidStyle_ ]
                        , inputBorderStyle borderRadius
                        , invalidStyle_
                        , disabledStyle isDisabled
                        , Css.property "gap" "12px"
                        , Css.padding (Css.px 16)
                        , Css.alignItems Css.center
                        ]
                    ]
                    [ childView leftChild isDisabled
                    , labelWithInputView model
                        [ Css.borderStyle Css.none
                        , Css.pseudoClass "focus-visible" [ Css.outline Css.none, defaultPlaceholderColor ]
                        , Css.width (Css.pct 100)
                        , Css.height (Css.px 54)
                        ]
                    , childView rightChild isDisabled
                    ]

        isValid =
            maybeError == Nothing
    in
    Html.div
        [ Attributes.id (inputWrapperId id)
        , Attributes.css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            , Css.property "gap" "4px"
            , Css.lineHeight (Css.px 20)
            , Css.fontSize (Css.px 14)

            -- This is currently used as a fix for Safari layout issues (TIP-3415)
            , Css.property "flex" "1 1 100%"

            --
            , Css.position Css.relative
            ]
        ]
        [ inputView_
        , hintView isValid hintText id
        , errorView maybeError id
        ]


inputView : Input msg -> List Css.Style -> Html msg
inputView (Settings { id, isDisabled, value, msg, borderRadius, isRequired, inputType, placeholder, maxLength, autocomplete, maybeError, attributes, onKeyDown }) variantBasedStyles =
    let
        autocompleteAttribute =
            autocomplete
                |> Maybe.map (Attributes.attribute "autocomplete")
                |> Maybe.withDefault (Attributes.attribute "autocomplete" "off")
    in
    Html.input
        ([ Attributes.css
            ([ baseInputStyle borderRadius
             , if isDisabled then
                Css.cursor Css.notAllowed

               else
                Css.batch []
             ]
                ++ variantBasedStyles
            )
         , Attributes.id (inputId id)
         , Attributes.disabled isDisabled
         , Attributes.required isRequired
         , Attributes.type_ inputType
         , Attributes.value value
         , Attributes.placeholder <| Maybe.withDefault "" placeholder
         , Events.onInput msg
         , Attributes.spellcheck False
         , Attributes.attribute "autocorrect" "off"
         , KeyPressUtil.onKeyDown onKeyDown
         , autocompleteAttribute
         , Attributes.maxlength maxLength
         , AccessibilityUtil.ariaInvalid (maybeError /= Nothing)
         , AccessibilityUtil.ariaDescribedByList [ errorId id, hintId id ]
         ]
            ++ attributes
        )
        []


childView : Maybe (Html msg) -> Bool -> Html msg
childView child isDisabled =
    case child of
        Just child_ ->
            Html.div
                [ Attributes.css
                    [ Css.displayFlex
                    , Css.Global.children
                        [ Css.Global.svg
                            [ Css.height (Css.px 24)
                            , if isDisabled then
                                Css.color (Css.hex "#424242")

                              else
                                Css.color (Css.hex "#000000")
                            ]
                        ]
                    ]
                ]
                [ child_ ]

        Nothing ->
            Html.text ""


labelWithInputView : Input msg -> List Css.Style -> Html msg
labelWithInputView ((Settings { value, isRequired, label, leftChild, rightChild, id, floatingLabelBackgroundColor }) as model) inputStyles =
    let
        notFocusedLabelStyles =
            if String.isEmpty value then
                let
                    leftPx =
                        if leftChild /= Nothing || rightChild /= Nothing then
                            0

                        else
                            16
                in
                [ Css.fontSize (Css.px 16)
                , Css.color (Css.hex "#454545")
                , Css.position Css.absolute
                , Css.top (Css.px 21)
                , Css.left (Css.px leftPx)
                , Css.lineHeight (Css.px 12)
                , Css.padding Css.zero
                , Css.whiteSpace Css.noWrap
                , Css.width (Css.pct 100)
                , Css.textOverflow Css.ellipsis
                , Css.property "overflow-x" "clip"
                , Css.pointerEvents Css.none
                ]

            else
                focusedLabelStyles

        focusedLabelStyles =
            [ Css.fontSize (Css.px 14)
            , Css.position Css.absolute
            , Css.top (Css.px -9)
            , Css.left (Css.px 10)
            , Css.lineHeight (Css.px 18)
            , Css.padding2 (Css.px 0) (Css.px 6)
            , Css.backgroundColor floatingLabelBackgroundColor
            , Css.color (Css.hex "#000000")
            , Css.width Css.unset
            ]
    in
    Html.div
        [ Attributes.css
            [ Css.displayFlex
            , Css.width (Css.pct 100)
            , Css.Global.children
                [ Css.Global.input
                    [ Css.focus
                        [ Css.Global.generalSiblings
                            [ Css.Global.label focusedLabelStyles ]
                        ]
                    ]
                ]
            , if String.isEmpty value then
                Css.position Css.relative

              else
                Css.position Css.static
            , Css.pseudoClass "focus-within" [ Css.position Css.static ]
            ]
        ]
        [ inputView model inputStyles
        , Html.label
            [ Attributes.id (labelId id)
            , Attributes.for (inputId id)
            , Attributes.css notFocusedLabelStyles
            ]
            [ Html.text label, AccessibilityUtil.requiredAsterisk isRequired ]
        ]


errorView : Maybe String -> String -> Html msg
errorView maybeError id =
    case maybeError of
        Just error ->
            Html.span
                [ Attributes.id <| errorId id
                , Attributes.css [ Css.color (Css.hex "#BB0E15"), Css.lineHeight (Css.px 18) ]
                ]
                [ Html.text error ]

        Nothing ->
            Html.text ""


hintView : Bool -> Maybe String -> String -> Html msg
hintView isValid hintText id =
    case hintText of
        Just hintText_ ->
            if isValid then
                Html.span
                    [ Attributes.id <| hintId id
                    , Attributes.css [ Css.color (Css.hex "#454545") ]
                    ]
                    [ Html.text hintText_ ]

            else
                Html.text ""

        Nothing ->
            Html.text ""


inputBorderStyle : Float -> Css.Style
inputBorderStyle borderRadius =
    Css.batch
        [ Css.border3 (Css.px 1) Css.solid (Css.hex "#767676")
        , Css.borderRadius (Css.px borderRadius)
        ]


baseInputStyle : Float -> Css.Style
baseInputStyle borderRadius =
    Css.batch
        [ Css.backgroundColor Css.transparent
        , inputBorderStyle borderRadius
        , Css.fontFamily Css.inherit
        , Css.fontSize (Css.px 16)
        , Css.fontWeight (Css.int 500)
        , Css.width (Css.pct 100)
        , Css.pseudoElement "placeholder" [ Css.color Css.transparent ]
        ]


disabledStyle : Bool -> Css.Style
disabledStyle isDisabled =
    if isDisabled then
        Css.batch
            [ Css.cursor Css.notAllowed
            , Css.opacity (Css.num 0.54)
            ]

    else
        Css.batch []


invalidStyle : Css.Style
invalidStyle =
    Css.batch
        [ Css.outlineColor (Css.hex "#BB0E15")
        , Css.borderColor (Css.hex "#BB0E15")
        ]


defaultFocusOutline : Css.Style
defaultFocusOutline =
    Css.batch
        [ Css.property "outline" "Highlight auto 2px"
        , Css.property "outline" "-webkit-focus-ring-color auto 2px"
        ]


defaultPlaceholderColor : Css.Style
defaultPlaceholderColor =
    Css.pseudoElement "placeholder" [ Css.color (Css.hex "#454545") ]
