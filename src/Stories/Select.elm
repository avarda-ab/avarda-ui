module Stories.Select exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Ui.Select
import Util.Controls exposing (ControlsFlags)


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
    { selectModel : Ui.Select.Model Option }


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
            \_ ->
                ( { selectModel =
                        Ui.Select.init "test-options"

                  -- |> Ui.Select.setSelectedOption Option1
                  }
                , Cmd.none
                )
        , update = \msg model -> update model msg
        , view =
            \{ selectModel } ->
                Html.div [ Attributes.css [ Css.displayFlex, Css.flexDirection Css.column, Css.maxWidth (Css.px 300) ] ]
                    [ Ui.Select.new { label = "Option select", selectModel = selectModel, optionToString = optionToString }
                        |> Ui.Select.setOptions [ Option1, Option2, Option3, Option4 ]
                        |> Ui.Select.withPlaceholder "Select option"
                        |> Ui.Select.withIsRequired
                        |> Ui.Select.withBorderRadius 8
                        |> Ui.Select.view HandleSelect
                    ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
