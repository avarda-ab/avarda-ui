module Ui.Input exposing (new, view, withAdditionalWrapperStyles, withBorderRadius, withHint, withInputType, withIsDisabled, withIsRequired, withLeftChild, withMaybeError, withPlaceholder, withRightChild)

import Css
import Css.Global
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Util.Accessibility as AccessibilityUtil


inputId : String -> String
inputId id =
    "avd-input-" ++ id


inputWrapperId : String -> String
inputWrapperId id =
    "avd-input-" ++ id ++ "-wrapper"


errorId : String -> String
errorId id =
    "avd-input-" ++ id ++ "-error"


hintId : String -> String
hintId id =
    "avd-input-" ++ id ++ "-hint"


childWrapperClass : String -> String
childWrapperClass id =
    "avd-input-" ++ id ++ "-child-class"


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
        , additionalWrapperStyles : List Css.Style
        , maybeError : Maybe String
        }


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
        , additionalWrapperStyles = []
        , maybeError = Nothing
        }


withMaybeError : Maybe String -> Input msg -> Input msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


withPlaceholder : String -> Input msg -> Input msg
withPlaceholder placeholder (Settings model) =
    Settings { model | placeholder = Just placeholder }


withLeftChild : Html msg -> Input msg -> Input msg
withLeftChild leftChild (Settings model) =
    Settings { model | leftChild = Just leftChild }


withRightChild : Html msg -> Input msg -> Input msg
withRightChild rightChild (Settings model) =
    Settings { model | rightChild = Just rightChild }


withIsRequired : Input msg -> Input msg
withIsRequired (Settings model) =
    Settings { model | isRequired = True }


withHint : String -> Input msg -> Input msg
withHint hintText (Settings model) =
    Settings { model | hintText = Just hintText }


withAdditionalWrapperStyles : List Css.Style -> Input msg -> Input msg
withAdditionalWrapperStyles additionalWrapperStyles (Settings model) =
    Settings { model | additionalWrapperStyles = additionalWrapperStyles }


withInputType : String -> Input msg -> Input msg
withInputType inputType (Settings model) =
    Settings { model | inputType = inputType }


withIsDisabled : Bool -> Input msg -> Input msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withBorderRadius : Float -> Input msg -> Input msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


view : Input msg -> Html msg
view ((Settings { label, leftChild, rightChild, borderRadius, id, isRequired, isDisabled, hintText, additionalWrapperStyles, maybeError }) as model) =
    let
        inputView_ =
            let
                invalidStyle_ =
                    if maybeError == Nothing then
                        Css.batch []

                    else
                        invalidStyle

                iconSizeGlobalStyle =
                    Css.Global.global
                        [ Css.Global.selector
                            -- TODO:
                            (String.join " "
                                [ "." ++ childWrapperClass id
                                , ">"
                                , "svg"
                                ]
                            )
                            [ Css.height (Css.px 24) ]
                        ]
            in
            if List.all ((==) Nothing) [ leftChild, rightChild ] then
                inputView model [ Css.minHeight (Css.px 48), invalidStyle_, disabledStyle isDisabled, Css.padding (Css.px 12) ]

            else
                Html.div
                    [ Attributes.id (inputWrapperId id)
                    , Attributes.css
                        [ Css.displayFlex
                        , Css.minHeight (Css.px 48)
                        , Css.pseudoClass "focus-within" [ defaultFocusOutline, invalidStyle_ ]
                        , inputBorderStyle borderRadius
                        , invalidStyle_
                        , disabledStyle isDisabled
                        , Css.property "gap" "12px"
                        , Css.padding (Css.px 12)
                        ]
                    ]
                    [ childView leftChild id
                    , inputView model [ Css.borderStyle Css.none, Css.pseudoClass "focus-visible" [ Css.outline Css.none ], Css.width (Css.pct 100) ]
                    , childView rightChild id
                    , iconSizeGlobalStyle
                    ]

        isValid =
            maybeError == Nothing
    in
    Html.div
        [ Attributes.css
            ([ Css.displayFlex
             , Css.flexDirection Css.column
             , Css.property "gap" "4px"
             , Css.lineHeight (Css.px 20)
             , Css.fontSize (Css.px 14)
             , Css.width (Css.pct 100)
             ]
                ++ additionalWrapperStyles
            )
        ]
        [ Html.label
            [ Attributes.for (inputId id), Attributes.css [ Css.lineHeight (Css.px 18) ] ]
            [ Html.text label, AccessibilityUtil.requiredAsterisk isRequired ]
        , inputView_
        , hintView isValid hintText id
        , errorView maybeError id
        ]


inputView : Input msg -> List Css.Style -> Html msg
inputView (Settings { id, isDisabled, value, msg, borderRadius, isRequired, inputType, placeholder, maxLength, autocomplete, maybeError }) variantBasedStyles =
    let
        autocompleteAttribute =
            autocomplete
                |> Maybe.map (Attributes.attribute "autocomplete")
                |> Maybe.withDefault (Attributes.attribute "autocomplete" "off")
    in
    Html.input
        [ Attributes.css
            ([ baseInputStyle borderRadius
             , disabledStyle isDisabled
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
        , autocompleteAttribute
        , Attributes.maxlength maxLength
        , AccessibilityUtil.ariaInvalid (maybeError /= Nothing)
        , AccessibilityUtil.ariaDescribedByList [ errorId id, hintId id ]
        ]
        []


childView : Maybe (Html msg) -> String -> Html msg
childView child id =
    case child of
        Just child_ ->
            Html.div [ Attributes.class (childWrapperClass id), Attributes.css [ Css.displayFlex ] ] [ child_ ]

        Nothing ->
            Html.text ""


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
        ]


disabledStyle : Bool -> Css.Style
disabledStyle isDisabled =
    if isDisabled then
        Css.batch
            [ Css.backgroundColor (Css.hex "#EEE")
            , Css.cursor Css.notAllowed

            -- TODO: Check if this is alright
            , Css.color (Css.hex "#767676")
            , Css.borderColor (Css.hex "#767676")
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
