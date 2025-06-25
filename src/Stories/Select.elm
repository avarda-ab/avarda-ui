module Stories.Select exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Ui.Select
import Util.Components exposing (withConditionalBuilder, withMaybeBuilder)
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)


type alias Controls =
    { label : String
    , error : Maybe String
    , maxHeight : Maybe Int
    , isRequired : Bool
    , isDisabled : Bool
    }



-- NOTE: Currently always overwritten by Button.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Test input"
    , error = Nothing
    , maxHeight = Nothing
    , isRequired = False
    , isDisabled = False
    }


controlsDecoder : Decode.Decoder Controls
controlsDecoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeMaybeStringControl "error"
        |> decodeMaybeIntControl "maxHeight"
        |> decodeBoolControl "required"
        |> decodeBoolControl "disabled"


type Option
    = Option1
    | Option2
    | Option3
    | Option4


optionToString : Option -> String
optionToString country =
    case country of
        Option1 ->
            "option1"

        Option2 ->
            "option2"

        Option3 ->
            "option3"

        Option4 ->
            "option4"


type Msg
    = HandleSelect (Ui.Select.Msg Option)
    | OnSelect Option
    | NoOp


type alias Model =
    ControlsModelExtended Controls { selectModel : Ui.Select.Model Option }


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        HandleSelect selectMsg ->
            let
                ( updatedSelectModel, selectCmd ) =
                    Ui.Select.updateWithCallbacks [ Ui.Select.onSelectCallback OnSelect ]
                        HandleSelect
                        selectMsg
                        model.selectModel
            in
            ( { model | selectModel = updatedSelectModel }, selectCmd )

        OnSelect string ->
            let
                _ =
                    Debug.log "OnSelect in parent" string
            in
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init =
            \controls ->
                ( { controls = decodeControls controls controlsDecoder defaultControls
                  , selectModel =
                        Ui.Select.init "test-options"

                  -- |> Ui.Select.setSelectedOption Option1
                  }
                , Cmd.none
                )
        , update = \msg model -> update model msg
        , view =
            \{ selectModel, controls } ->
                let
                    { error, isDisabled, isRequired, label, maxHeight } =
                        controls
                in
                Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.column, Css.maxWidth (Css.px 300) ] ]
                    [ Ui.Select.new { label = label, selectModel = selectModel, optionToString = optionToString }
                        |> Ui.Select.setOptions [ Option1, Option2, Option3, Option4 ]
                        |> Ui.Select.withIsDisabled isDisabled
                        |> Ui.Select.withBorderRadius 8
                        |> Ui.Select.withMaybeError error
                        |> withConditionalBuilder Ui.Select.withIsRequired isRequired
                        |> withMaybeBuilder Ui.Select.withMenuMaxHeight maxHeight
                        |> Ui.Select.view HandleSelect
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
