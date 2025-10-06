module Stories.SuggestionInput exposing (main)

import AvardaUi.SuggestionInput
import AvardaUi.Util.Builder exposing (withConditionalBuilder, withMaybeBuilder)
import AvardaUi.Util.Icon exposing (mockIconView)
import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)


type alias Controls =
    { label : String
    , placeholder : Maybe String
    , hint : Maybe String
    , error : Maybe String
    , isRequired : Bool
    , isDisabled : Bool
    , showIconLeft : Bool
    , showIconRight : Bool
    , maxHeight : Maybe Int
    }



-- NOTE: Currently always overwritten by SuggestionInput.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Test suggestion input"
    , placeholder = Nothing
    , hint = Nothing
    , error = Nothing
    , isRequired = False
    , isDisabled = False
    , showIconLeft = False
    , showIconRight = False
    , maxHeight = Nothing
    }


controlsDecoder : Decode.Decoder Controls
controlsDecoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeMaybeStringControl "placeholder"
        |> decodeMaybeStringControl "hint"
        |> decodeMaybeStringControl "error"
        |> decodeBoolControl "required"
        |> decodeBoolControl "disabled"
        |> decodeBoolControl "showIconLeft"
        |> decodeBoolControl "showIconRight"
        |> decodeMaybeIntControl "maxMenuHeight"


type Suggestion
    = Suggestion1
    | Suggestion2
    | Suggestion3
    | Suggestion4
    | Suggestion5
    | Suggestion6
    | Suggestion7
    | Suggestion8
    | Suggestion9


optionToString : Suggestion -> String
optionToString option =
    case option of
        Suggestion1 ->
            "naughty airplane"

        Suggestion2 ->
            "smelly airplane"

        Suggestion3 ->
            "obese ice"

        Suggestion4 ->
            "obese orange"

        Suggestion5 ->
            "astro chair"

        Suggestion6 ->
            "aqua volcano"

        Suggestion7 ->
            "thong sandwich"

        Suggestion8 ->
            "aqua dragon"

        Suggestion9 ->
            "strong banana"


suggestions : List Suggestion
suggestions =
    [ Suggestion1, Suggestion2, Suggestion3, Suggestion4, Suggestion5, Suggestion6, Suggestion7, Suggestion8, Suggestion9 ]


type Msg
    = HandleSelect (AvardaUi.SuggestionInput.Msg Suggestion)
    | OnSelect Suggestion
    | InsertedValue String
    | NoOp


type alias Model =
    ControlsModelExtended Controls { suggestionInputModel : AvardaUi.SuggestionInput.Model Suggestion }


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        HandleSelect selectMsg ->
            let
                ( updatedSuggestionInputModel, selectCmd ) =
                    AvardaUi.SuggestionInput.updateWith
                        [ AvardaUi.SuggestionInput.onInput InsertedValue
                        , AvardaUi.SuggestionInput.onSelect OnSelect
                        ]
                        HandleSelect
                        selectMsg
                        model.suggestionInputModel
            in
            ( { model | suggestionInputModel = updatedSuggestionInputModel }, selectCmd )

        OnSelect _ ->
            ( model, Cmd.none )

        InsertedValue _ ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init =
            \controls ->
                ( { controls = decodeControls controls controlsDecoder defaultControls
                  , suggestionInputModel =
                        AvardaUi.SuggestionInput.init "test-suggestions"
                            |> AvardaUi.SuggestionInput.setSuggestions suggestions
                  }
                , Cmd.none
                )
        , update = \msg model -> update model msg
        , view =
            \{ suggestionInputModel, controls } ->
                let
                    { label, placeholder, hint, error, isRequired, isDisabled, showIconLeft, showIconRight, maxHeight } =
                        controls
                in
                Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.column, Css.maxWidth (Css.px 300) ] ]
                    [ AvardaUi.SuggestionInput.new { label = label, suggestionInputModel = suggestionInputModel, suggestionToInputValue = optionToString }
                        |> AvardaUi.SuggestionInput.withIsDisabled isDisabled
                        |> AvardaUi.SuggestionInput.withBorderRadius 8
                        |> AvardaUi.SuggestionInput.withMaybeError error
                        |> AvardaUi.SuggestionInput.withIsRequired isRequired
                        |> withConditionalBuilder (AvardaUi.SuggestionInput.withLeftChild mockIconView) showIconLeft
                        |> withConditionalBuilder (AvardaUi.SuggestionInput.withRightChild mockIconView) showIconRight
                        |> withMaybeBuilder AvardaUi.SuggestionInput.withPlaceholder placeholder
                        |> withMaybeBuilder AvardaUi.SuggestionInput.withHint hint
                        |> withMaybeBuilder AvardaUi.SuggestionInput.withMenuMaxHeight maxHeight
                        |> AvardaUi.SuggestionInput.view HandleSelect
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
