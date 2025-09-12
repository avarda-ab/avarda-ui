module AvardaUi.SelectNative exposing (new, setBasicOptions, setOptionGroups, view, withAriaLabel, withBorderRadius, withCustomOptionSorting, withIsDisabled, withIsRequired, withMaybeError, withOptionToLabel)

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Json.Decode as Decode
import List.Extra
import Util.Accessibility as AccessibilityUtil
import Util.Icon as Icon


baseId : String
baseId =
    "avd-selectnative-"


selectId : String -> String
selectId id =
    baseId ++ id


labelId : String -> String
labelId id =
    baseId ++ id ++ "-label"


errorId : String -> String
errorId id =
    baseId ++ id ++ "-error"


type Select a msg
    = Settings
        { id : String
        , onChange : a -> msg
        , selectedOption : Maybe a
        , placeholder : String
        , options : OptionType a
        , optionToStringValue : a -> String
        , stringValueToOption : String -> a
        , maybeOptionToLabel : Maybe (a -> String)
        , maybeError : Maybe String
        , isRequired : Bool
        , isDisabled : Bool
        , label : String
        , borderRadius : Float
        , ariaLabel : Maybe String
        }


type OptionType a
    = BasicOptionList (List a)
    | OptionGroupList (List (List a))


new :
    String
    ->
        { label : String
        , optionToStringValue : a -> String
        , stringValueToOption : String -> a
        , onChange : a -> msg
        , placeholder : String
        , selectedOption : Maybe a
        }
    -> Select a msg
new id { label, optionToStringValue, onChange, selectedOption, placeholder, stringValueToOption } =
    let
        -- TODO: Should be part of Theme
        defaultBorderRadius =
            8
    in
    Settings
        { id = id
        , onChange = onChange
        , selectedOption = selectedOption
        , placeholder = placeholder
        , maybeError = Nothing
        , isRequired = False
        , isDisabled = False
        , options = BasicOptionList []
        , label = label
        , borderRadius = defaultBorderRadius
        , ariaLabel = Nothing
        , optionToStringValue = optionToStringValue
        , stringValueToOption = stringValueToOption
        , maybeOptionToLabel = Nothing
        }


withMaybeError : Maybe String -> Select a msg -> Select a msg
withMaybeError maybeError (Settings model) =
    Settings { model | maybeError = maybeError }


withIsRequired : Bool -> Select a msg -> Select a msg
withIsRequired isRequired (Settings model) =
    Settings { model | isRequired = isRequired }


withIsDisabled : Bool -> Select a msg -> Select a msg
withIsDisabled isDisabled (Settings model) =
    Settings { model | isDisabled = isDisabled }


withBorderRadius : Float -> Select a msg -> Select a msg
withBorderRadius borderRadius (Settings model) =
    Settings { model | borderRadius = borderRadius }


withAriaLabel : String -> Select a msg -> Select a msg
withAriaLabel ariaLabel (Settings model) =
    Settings { model | ariaLabel = Just ariaLabel }


withOptionToLabel : (a -> String) -> Select a msg -> Select a msg
withOptionToLabel optionToLabel (Settings model) =
    Settings { model | maybeOptionToLabel = Just optionToLabel }


withCustomOptionSorting : (List a -> List a) -> Select a msg -> Select a msg
withCustomOptionSorting sortFn (Settings model) =
    Settings
        { model
            | options =
                case model.options of
                    BasicOptionList basicOptionList ->
                        List.Extra.unique basicOptionList |> sortFn |> BasicOptionList

                    OptionGroupList optionGroupList ->
                        List.map (List.Extra.unique >> sortFn) optionGroupList |> OptionGroupList
        }


setBasicOptions : List a -> Select a msg -> Select a msg
setBasicOptions optionList (Settings ({ optionToStringValue } as model)) =
    Settings { model | options = optionList |> List.Extra.unique |> List.sortBy optionToStringValue |> BasicOptionList }


setOptionGroups : List (List a) -> Select a msg -> Select a msg
setOptionGroups optionGroupList (Settings ({ optionToStringValue } as model)) =
    Settings { model | options = optionGroupList |> List.map (List.Extra.unique >> List.sortBy optionToStringValue) |> OptionGroupList }


view : Select a msg -> Html msg
view ((Settings { id, isDisabled, label, borderRadius, isRequired, ariaLabel, maybeError, onChange, stringValueToOption }) as model) =
    let
        isInvalid =
            maybeError /= Nothing

        labelView =
            Html.span
                [ Attributes.css
                    [ Css.fontSize (Css.px 14)
                    , Css.position Css.absolute
                    , Css.top (Css.px -9)
                    , Css.left (Css.px 10)
                    , Css.lineHeight (Css.px 18)
                    , Css.padding2 (Css.px 0) (Css.px 6)
                    , Css.backgroundColor (Css.hex "#FFFFFF")
                    ]
                , Attributes.id <| labelId id
                ]
                [ Html.text label, AccessibilityUtil.requiredAsterisk isRequired ]

        ariaLabelAttribute =
            ariaLabel
                |> Maybe.map AccessibilityUtil.ariaLabel
                |> Maybe.withDefault (AccessibilityUtil.ariaLabelledBy <| labelId id)

        onChangeEvent msg =
            Events.on "change" (Decode.map msg Events.targetValue)
    in
    Html.div
        [ Attributes.css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            , Css.width (Css.pct 100)
            , Css.fontSize (Css.px 16)
            , Css.lineHeight (Css.px 12)
            , Css.property "gap" "4px"
            , Css.position Css.relative
            , disabledStyle isDisabled
            ]
        ]
        [ labelView
        , Html.select
            [ Attributes.id <| selectId id
            , onChangeEvent (onChange << stringValueToOption)
            , Attributes.css
                [ Css.displayFlex
                , Css.padding2 (Css.px 12) (Css.px 16)
                , Css.border3 (Css.px 1) Css.solid (Css.hex "#767676")
                , Css.width (Css.pct 100)
                , Css.borderRadius (Css.px borderRadius)
                , Css.height (Css.px 54)
                , Css.fontSize (Css.px 16)
                , invalidStyle isInvalid
                , Css.disabled [ Css.opacity Css.unset, Css.cursor Css.notAllowed ]
                , Css.property "appearance" "none"
                , Css.property "background" "none"
                , Css.color (Css.hex "#000")
                ]
            , Attributes.required isRequired
            , Attributes.disabled isDisabled
            , AccessibilityUtil.ariaInvalid isInvalid
            , AccessibilityUtil.ariaDescribedBy <| errorId id
            , ariaLabelAttribute
            ]
            (optionGroupListView model)
        , Html.span
            [ Attributes.css
                [ Css.position Css.absolute
                , Css.right <| Css.px 16
                , Css.top <| Css.px 15
                , Css.pointerEvents Css.none
                ]
            ]
            [ Icon.arrowDown ]
        , errorView maybeError <| errorId id
        ]


errorView : Maybe String -> String -> Html msg
errorView maybeError id =
    case maybeError of
        Just error ->
            Html.span
                [ Attributes.id id
                , Attributes.css [ Css.fontSize (Css.px 14), Css.lineHeight (Css.px 18), Css.color (Css.hex "#BB0E15") ]
                ]
                [ Html.text error ]

        Nothing ->
            Html.text ""


optionGroupListView : Select a msg -> List (Html msg)
optionGroupListView (Settings { options, placeholder, selectedOption, optionToStringValue, maybeOptionToLabel }) =
    let
        placeholderOption =
            Html.option
                [ Attributes.disabled True
                , Attributes.selected <| selectedOption == Nothing
                , Attributes.value ""
                ]
                [ Html.text placeholder ]

        optionView option =
            Html.option
                [ Attributes.selected <| selectedOption == Just option
                , Attributes.value <| optionToStringValue option
                ]
                [ maybeOptionToLabel
                    |> Maybe.map (\optionToLabel -> optionToLabel option)
                    |> Maybe.withDefault (optionToStringValue option)
                    |> Html.text
                ]

        optgroupView =
            List.map optionView
                >> Html.optgroup []

        optgroups =
            case options of
                BasicOptionList optionList ->
                    List.map optionView optionList

                OptionGroupList optionGroupList ->
                    List.map optgroupView optionGroupList
    in
    placeholderOption :: optgroups


disabledStyle : Bool -> Css.Style
disabledStyle isDisabled =
    if isDisabled then
        Css.batch
            [ Css.cursor Css.notAllowed
            , Css.opacity <| Css.num 0.54
            ]

    else
        Css.batch []


invalidStyle : Bool -> Css.Style
invalidStyle isInvalid =
    if isInvalid then
        Css.batch
            [ Css.outlineColor (Css.hex "#BB0E15")
            , Css.borderColor (Css.hex "#BB0E15")
            ]

    else
        Css.batch []
