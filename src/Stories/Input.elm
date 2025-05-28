module Stories.Input exposing (main)

import Browser
import Css
import Html.Styled as Html
import Html.Styled.Attributes as Attributes
import Ui.Input
import Util.Controls exposing (ControlsFlags)
import Util.Icon exposing (mockIconView)


type alias Model =
    { value : String }


type Msg
    = InsertedValue String
    | NoOp


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        InsertedValue value ->
            ( { model | value = value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program ControlsFlags Model Msg
main =
    Browser.element
        { init = \_ -> ( { value = "" }, Cmd.none )
        , update = \msg model -> update msg model
        , view =
            \{ value } ->
                Ui.Input.new "test-input" { value = value, msg = InsertedValue, label = "Test input" }
                    |> Ui.Input.withLeftChild mockIconView
                    |> Ui.Input.view
                    |> List.singleton
                    |> Html.div [ Attributes.css [ Css.maxWidth (Css.px 300) ] ]
                    |> Html.toUnstyled
        , subscriptions = \_ -> Sub.none
        }
