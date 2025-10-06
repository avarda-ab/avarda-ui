module Stories.Select exposing (main)

import AvardaUi.Select
import AvardaUi.Util.Builder exposing (withConditionalBuilder, withMaybeBuilder)
import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)


type alias Controls =
    { label : String
    , error : Maybe String
    , maxHeight : Maybe Int
    , isRequired : Bool
    , isDisabled : Bool
    }



-- NOTE: Currently always overwritten by Select.stories.js (args property) unless decoder fails


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
optionToString option =
    case option of
        Option1 ->
            "option1"

        Option2 ->
            "option2"

        Option3 ->
            "option3"

        Option4 ->
            "option4"


type Msg
    = HandleSelect (AvardaUi.Select.Msg Option)
    | OnSelect Option
    | NoOp


type alias Model =
    ControlsModelExtended Controls { selectModel : AvardaUi.Select.Model Option }


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        HandleSelect selectMsg ->
            let
                ( updatedSelectModel, selectCmd ) =
                    AvardaUi.Select.updateWith [ AvardaUi.Select.onSelect OnSelect ]
                        HandleSelect
                        selectMsg
                        model.selectModel
            in
            ( { model | selectModel = updatedSelectModel }, selectCmd )

        OnSelect _ ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init =
            \controls ->
                ( { controls = decodeControls controls controlsDecoder defaultControls
                  , selectModel = AvardaUi.Select.init "test-options"
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
                    [ AvardaUi.Select.new { label = label, selectModel = selectModel, optionToString = optionToString }
                        |> AvardaUi.Select.setOptions [ Option1, Option2, Option3, Option4 ]
                        |> AvardaUi.Select.withIsDisabled isDisabled
                        |> AvardaUi.Select.withBorderRadius 8
                        |> AvardaUi.Select.withMaybeError error
                        |> withConditionalBuilder AvardaUi.Select.withIsRequired isRequired
                        |> withMaybeBuilder AvardaUi.Select.withMenuMaxHeight maxHeight
                        |> AvardaUi.Select.view HandleSelect
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
