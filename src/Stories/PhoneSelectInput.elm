module Stories.PhoneSelectInput exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Ui.PhoneSelectInput
import Util.Controls exposing (ControlsFlags)



-- type Value a
--     = Valid a
--     | Invalid a String


type Msg
    = HandlePhoneSelectInput Ui.PhoneSelectInput.Msg
    | OnSelect Ui.PhoneSelectInput.CountryCode
    | OnInput String
    | NoOp


type alias Model =
    { phoneSelectInputModel : Ui.PhoneSelectInput.Model }


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

        OnSelect string ->
            let
                _ =
                    Debug.log "OnSelect in parent" string
            in
            ( model, Cmd.none )

        OnInput string ->
            let
                _ =
                    Debug.log "OnInput in parent" string
            in
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init =
            \_ ->
                ( { phoneSelectInputModel =
                        Ui.PhoneSelectInput.init "dialing-code"
                            |> Ui.PhoneSelectInput.setSelectedOption Ui.PhoneSelectInput.SE
                  }
                , Cmd.none
                )
        , update = \msg model -> update model msg
        , view =
            \{ phoneSelectInputModel } ->
                Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.column, Css.maxWidth (Css.px 300) ] ]
                    [ Ui.PhoneSelectInput.new { inputLabel = "Phone number", selectAriaLabel = "Dialing code", phoneSelectInputModel = phoneSelectInputModel }
                        |> Ui.PhoneSelectInput.setOptions [ Ui.PhoneSelectInput.SE, Ui.PhoneSelectInput.CZ, Ui.PhoneSelectInput.FI, Ui.PhoneSelectInput.SE, Ui.PhoneSelectInput.NO, Ui.PhoneSelectInput.DK ]
                        |> Ui.PhoneSelectInput.view HandlePhoneSelectInput
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
