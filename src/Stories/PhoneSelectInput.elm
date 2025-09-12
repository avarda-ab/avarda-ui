module Stories.PhoneSelectInput exposing (main)

import AvardaUi.PhoneSelectInput
import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Json.Decode as Decode
import Shared.Data exposing (CountryCode(..))
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
    = HandlePhoneSelectInput AvardaUi.PhoneSelectInput.Msg
    | OnSelect CountryCode
    | OnInput String
    | NoOp


type alias Model =
    ControlsModelExtended Controls { phoneSelectInputModel : AvardaUi.PhoneSelectInput.Model }


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        HandlePhoneSelectInput selectMsg ->
            let
                ( updatedSelectModel, selectCmd ) =
                    AvardaUi.PhoneSelectInput.updateWithCallbacks
                        [ AvardaUi.PhoneSelectInput.onSelectCallback OnSelect
                        , AvardaUi.PhoneSelectInput.onInputCallback OnInput
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
                        AvardaUi.PhoneSelectInput.init "dialing-code"
                            |> AvardaUi.PhoneSelectInput.setSelectedOption SE
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
                    [ AvardaUi.PhoneSelectInput.new { inputLabel = label, selectAriaLabel = "Dialing code", phoneSelectInputModel = phoneSelectInputModel }
                        |> AvardaUi.PhoneSelectInput.setOptions [ SE, CZ, FI, SE, NO, DK ]
                        |> AvardaUi.PhoneSelectInput.withIsDisabled isDisabled
                        |> AvardaUi.PhoneSelectInput.withMaybeError error
                        |> AvardaUi.PhoneSelectInput.withIsRequired isRequired
                        |> withMaybeBuilder AvardaUi.PhoneSelectInput.withMenuMaxHeight maxHeight
                        |> withMaybeBuilder AvardaUi.PhoneSelectInput.withInputPlaceholder placeholder
                        |> withMaybeBuilder AvardaUi.PhoneSelectInput.withHint hint
                        |> AvardaUi.PhoneSelectInput.view HandlePhoneSelectInput
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
