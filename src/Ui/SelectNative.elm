module Ui.SelectNative exposing (new, setOptionGroups, setOptions, view, withAriaLabel, withBorderRadius, withIsDisabled, withIsRequired, withMaybeError, withOptionToLabel)

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
        , onChange : String -> msg
        , selectedOption : Maybe a
        , placeholder : String
        , optionGroupList : List (List a)
        , optionToStringValue : a -> String
        , maybeOptionToLabel : Maybe (a -> String)
        , maybeError : Maybe String
        , isRequired : Bool
        , isDisabled : Bool
        , label : String
        , borderRadius : Float
        , ariaLabel : Maybe String
        }


new : String -> { label : String, optionToStringValue : a -> String, onChange : String -> msg, placeholder : String, selectedOption : Maybe a } -> Select a msg
new id { label, optionToStringValue, onChange, selectedOption, placeholder } =
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
        , optionGroupList = []
        , label = label
        , borderRadius = defaultBorderRadius
        , ariaLabel = Nothing
        , optionToStringValue = optionToStringValue
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
withAriaLabel id (Settings model) =
    Settings { model | ariaLabel = Just id }


setOptions : List a -> Select a msg -> Select a msg
setOptions optionList (Settings ({ optionToStringValue } as model)) =
    Settings { model | optionGroupList = [ optionList |> List.Extra.unique |> List.sortBy optionToStringValue ] }


setOptionGroups : List (List a) -> Select a msg -> Select a msg
setOptionGroups optionGroupList (Settings ({ optionToStringValue } as model)) =
    Settings { model | optionGroupList = optionGroupList |> List.map (List.Extra.unique >> List.sortBy optionToStringValue) }


withOptionToLabel : (a -> String) -> Select a msg -> Select a msg
withOptionToLabel optionToLabel (Settings model) =
    Settings { model | maybeOptionToLabel = Just optionToLabel }


view : Select a msg -> Html msg
view ((Settings { id, isDisabled, label, borderRadius, isRequired, ariaLabel, maybeError, onChange }) as model) =
    let
        isInvalid =
            maybeError /= Nothing

        maybeLabelView =
            if ariaLabel == Nothing then
                let
                    labelStyles =
                        [ Css.fontSize (Css.px 14)
                        , Css.position Css.absolute
                        , Css.top (Css.px -9)
                        , Css.left (Css.px 10)
                        , Css.lineHeight (Css.px 18)
                        , Css.padding2 (Css.px 0) (Css.px 6)
                        , Css.backgroundColor (Css.hex "#FFFFFF")
                        ]
                in
                Html.span [ Attributes.css labelStyles, Attributes.id <| labelId id ] [ Html.text label, AccessibilityUtil.requiredAsterisk isRequired ]

            else
                Html.text ""

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
            , Css.fontSize (Css.px 16)
            , Css.lineHeight (Css.px 12)
            , Css.property "gap" "4px"
            , Css.position Css.relative
            , disabledStyle isDisabled
            ]
        ]
        [ maybeLabelView
        , Html.select
            [ Attributes.id <| selectId id
            , onChangeEvent onChange
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
optionGroupListView (Settings { optionGroupList, placeholder, selectedOption, optionToStringValue, maybeOptionToLabel }) =
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
