module Stories.PhoneSelectInput exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Shared.Data exposing (CountryCode(..))
import Ui.PhoneSelectInput
import Util.Components exposing (withMaybeBuilder)
import Util.Controls exposing (ControlsFlags, ControlsModelExtended, decodeBoolControl, decodeControls, decodeMaybeIntControl, decodeMaybeStringControl, decodeStringControl)


type alias Controls =
    { label : String
    , placeholder : Maybe String
    , hint : Maybe String
    , error : Maybe String
    , maxHeight : Maybe Int
    , isRequired : Bool
    , isDisabled : Bool
    }



-- NOTE: Currently always overwritten by PhoneSelectInput.stories.js (args property) unless decoder fails


defaultControls : Controls
defaultControls =
    { label = "Test input"
    , placeholder = Nothing
    , hint = Nothing
    , error = Nothing
    , maxHeight = Nothing
    , isRequired = False
    , isDisabled = False
    }


controlsDecoder : Decode.Decoder Controls
controlsDecoder =
    Decode.succeed Controls
        |> decodeStringControl "label"
        |> decodeMaybeStringControl "placeholder"
        |> decodeMaybeStringControl "hint"
        |> decodeMaybeStringControl "error"
        |> decodeMaybeIntControl "maxHeight"
        |> decodeBoolControl "required"
        |> decodeBoolControl "disabled"


type Msg
    = HandlePhoneSelectInput Ui.PhoneSelectInput.Msg
    | OnSelect CountryCode
    | OnInput String
    | NoOp


type alias Model =
    ControlsModelExtended Controls { phoneSelectInputModel : Ui.PhoneSelectInput.Model }


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        HandlePhoneSelectInput selectMsg ->
            let
                ( updatedSelectModel, selectCmd ) =
                    Ui.PhoneSelectInput.updateWithCallbacks
                        [ Ui.PhoneSelectInput.onSelectCallback OnSelect
                        , Ui.PhoneSelectInput.onInputCallback OnInput
                        ]
                        HandlePhoneSelectInput
                        selectMsg
                        model.phoneSelectInputModel
            in
            ( { model | phoneSelectInputModel = updatedSelectModel }, selectCmd )

        OnSelect _ ->
            ( model, Cmd.none )

        OnInput _ ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init =
            \controls ->
                ( { phoneSelectInputModel =
                        Ui.PhoneSelectInput.init "dialing-code"
                            |> Ui.PhoneSelectInput.setSelectedOption SE
                  , controls = decodeControls controls controlsDecoder defaultControls
                  }
                , Cmd.none
                )
        , update = \msg model -> update model msg
        , view =
            \{ phoneSelectInputModel, controls } ->
                let
                    { error, isDisabled, isRequired, label, maxHeight, placeholder, hint } =
                        controls
                in
                Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.column, Css.maxWidth (Css.px 300) ] ]
                    [ Ui.PhoneSelectInput.new { inputLabel = label, selectAriaLabel = "Dialing code", phoneSelectInputModel = phoneSelectInputModel }
                        |> Ui.PhoneSelectInput.setOptions [ SE, CZ, FI, SE, NO, DK ]
                        |> Ui.PhoneSelectInput.withIsDisabled isDisabled
                        |> Ui.PhoneSelectInput.withMaybeError error
                        |> Ui.PhoneSelectInput.withIsRequired isRequired
                        |> withMaybeBuilder Ui.PhoneSelectInput.withMenuMaxHeight maxHeight
                        |> withMaybeBuilder Ui.PhoneSelectInput.withInputPlaceholder placeholder
                        |> withMaybeBuilder Ui.PhoneSelectInput.withHint hint
                        |> Ui.PhoneSelectInput.view HandlePhoneSelectInput
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
