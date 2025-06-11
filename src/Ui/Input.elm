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


labelId : String -> String
labelId id =
    "avd-input-" ++ id ++ "-label"


inputWrapperId : String -> String
inputWrapperId id =
    "avd-input-" ++ id ++ "-wrapper"


errorId : String -> String
errorId id =
    "avd-input-" ++ id ++ "-error"


hintId : String -> String
hintId id =
    "avd-input-" ++ id ++ "-hint"


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
view ((Settings { leftChild, rightChild, borderRadius, id, isDisabled, hintText, additionalWrapperStyles, maybeError }) as model) =
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
                    [ Attributes.id (inputWrapperId id)
                    , Attributes.css
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
                    [ childView leftChild
                    , labelWithInputView model
                        [ Css.borderStyle Css.none
                        , Css.pseudoClass "focus-visible" [ Css.outline Css.none, defaultPlaceholderColor ]
                        , Css.width (Css.pct 100)
                        ]
                    , childView rightChild
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
             , Css.position Css.relative
             ]
                ++ additionalWrapperStyles
            )
        ]
        [ inputView_
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


childView : Maybe (Html msg) -> Html msg
childView child =
    case child of
        Just child_ ->
            Html.div
                [ Attributes.css
                    [ Css.displayFlex
                    , Css.Global.children
                        [ Css.Global.svg [ Css.height (Css.px 24) ]
                        ]
                    ]
                ]
                [ child_ ]

        Nothing ->
            Html.text ""


labelWithInputView : Input msg -> List Css.Style -> Html msg
labelWithInputView ((Settings { value, isRequired, label, leftChild, id }) as model) inputStyles =
    let
        notFocusedLabelStyles =
            if String.isEmpty value then
                let
                    ( topPx, leftPx ) =
                        if leftChild /= Nothing then
                            ( 5, 0 )

                        else
                            ( 22, 16 )
                in
                [ Css.fontSize (Css.px 16)
                , Css.color (Css.hex "#454545")
                , Css.position Css.absolute
                , Css.top (Css.px topPx)
                , Css.left (Css.px leftPx)
                , Css.lineHeight (Css.px 12)
                , Css.padding Css.zero
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
            , Css.backgroundColor (Css.hex "#FFFFFF")
            , Css.color (Css.hex "#000000")
            ]
    in
    Html.div
        [ Attributes.css
            ([ Css.displayFlex
             , Css.width (Css.pct 100)
             , Css.Global.children
                [ Css.Global.input
                    [ Css.focus
                        [ Css.Global.generalSiblings
                            [ Css.Global.label focusedLabelStyles ]
                        ]
                    ]
                ]
             ]
                ++ (if leftChild /= Nothing then
                        [ if String.isEmpty value then
                            Css.position Css.relative

                          else
                            Css.position Css.static
                        , Css.pseudoClass "focus-within" [ Css.position Css.static ]
                        ]

                    else
                        []
                   )
            )
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
        , Css.width (Css.pct 100)
        , Css.pseudoElement "placeholder" [ Css.color Css.transparent ]
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


defaultPlaceholderColor : Css.Style
defaultPlaceholderColor =
    Css.pseudoElement "placeholder" [ Css.color (Css.hex "#454545") ]
