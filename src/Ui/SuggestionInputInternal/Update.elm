module Ui.SuggestionInputInternal.Update exposing (RemoteSuggestionsPayload, ScrollSuggestionIntoViewCmd, UpdateOption(..), UpdateOptions, update, updateWith)

import Browser.Dom as Dom
import List.Extra
import Process
import RemoteData
import Task
import Ui.SuggestionInputInternal.Model as Model exposing (Model)
import Ui.SuggestionInputInternal.Msg exposing (Msg(..))


type UpdateOption a msg
    = OnSelect (a -> msg)
    | OnInput (String -> msg)
    | RemoteSuggestions (RemoteSuggestionsPayload a msg)
    | ScrollSuggestionIntoView (ScrollSuggestionIntoViewCmd msg)


type alias UpdateOptions a msg =
    { onSelect : Maybe (a -> msg)
    , remoteSuggestions : Maybe (RemoteSuggestionsPayload a msg)
    , onInput : Maybe (String -> msg)
    , scrollSuggestionIntoViewCmd : Maybe (ScrollSuggestionIntoViewCmd msg)
    }


type alias RemoteSuggestionsPayload a msg =
    { requestCmd : String -> (RemoteData.WebData (List a) -> msg) -> Cmd msg
    , requestMinInputLength : Int
    }


type alias ScrollSuggestionIntoViewCmd msg =
    String -> Cmd msg


defaultUpdateOptions : UpdateOptions a msg
defaultUpdateOptions =
    { onSelect = Nothing, onInput = Nothing, remoteSuggestions = Nothing, scrollSuggestionIntoViewCmd = Nothing }


updateOptionsFromList : List (UpdateOption a msg) -> UpdateOptions a msg
updateOptionsFromList =
    List.foldl
        (\opt opts ->
            case opt of
                OnSelect msg ->
                    { opts | onSelect = Just msg }

                OnInput msg ->
                    { opts | onInput = Just msg }

                RemoteSuggestions remoteSuggestionsPayload ->
                    { opts | remoteSuggestions = Just remoteSuggestionsPayload }

                ScrollSuggestionIntoView scrollSuggestionIntoViewCmd ->
                    { opts | scrollSuggestionIntoViewCmd = Just scrollSuggestionIntoViewCmd }
        )
        defaultUpdateOptions


update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    updateRaw (updateOptionsFromList [])


updateWith : List (UpdateOption a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWith callbackList =
    updateRaw (updateOptionsFromList callbackList)


updateRaw : UpdateOptions a msg -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateRaw { onSelect, onInput, remoteSuggestions, scrollSuggestionIntoViewCmd } wrapMsg msg model =
    let
        isSuggestionsExpanded =
            Model.getIsSuggestionsExpanded model
    in
    case msg of
        HandleEnter suggestionToInputValue ->
            if isSuggestionsExpanded then
                ( model, Cmd.none )
                    |> andThen (selectSuggestion onSelect (getHighlightedOption model) suggestionToInputValue)
                    |> andThen hideSuggestions

            else
                showSuggestionsAndMoveToSelected wrapMsg scrollSuggestionIntoViewCmd remoteSuggestions model

        HandleEsc ->
            -- Accessibility
            --   If suggestions are displayed, Esc closes it
            --   If suggestions are NOT displayed, Esc clears the input
            if isSuggestionsExpanded then
                hideSuggestions model

            else
                ( model, Cmd.none )
                    |> andThen (updateInputValue onInput "")
                    |> andThen resetSuggestions

        Toggle ->
            if not <| isSuggestionsExpanded then
                showSuggestionsAndMoveToSelected wrapMsg scrollSuggestionIntoViewCmd remoteSuggestions model

            else
                ( model, Cmd.none )

        Select suggestion suggestionToInputValue ->
            ( model, Cmd.none )
                |> andThen (selectSuggestion onSelect (Just suggestion) suggestionToInputValue)
                |> andThen hideSuggestions

        HandleArrowDown ->
            if isSuggestionsExpanded then
                moveHighlightDown wrapMsg scrollSuggestionIntoViewCmd model

            else
                showSuggestionsAndMoveToSelected wrapMsg scrollSuggestionIntoViewCmd remoteSuggestions model

        HandleArrowUp ->
            if isSuggestionsExpanded then
                moveHighlightUp wrapMsg scrollSuggestionIntoViewCmd model

            else
                ( model, Cmd.none )
                    |> andThen (showSuggestions remoteSuggestions)
                    |> andThen (moveHighlight wrapMsg scrollSuggestionIntoViewCmd (Just 0))

        HandleOnBlur suggestionToInputValue ->
            if isSuggestionsExpanded then
                ( model, Cmd.none )
                    |> andThen (selectSuggestion onSelect (getHighlightedOption model) suggestionToInputValue)
                    |> andThen hideSuggestions

            else
                hideSuggestions model

        HandleOnFocus ->
            showSuggestionsAndMoveToSelected wrapMsg scrollSuggestionIntoViewCmd remoteSuggestions model

        InsertedValue suggestionToInputValue value ->
            ( model, Cmd.none )
                |> andThen (updateInputValue onInput value)
                |> andThen clearSelectedSuggestion
                |> (case remoteSuggestions of
                        Just { requestMinInputLength } ->
                            let
                                maybeClearSuggestions model_ =
                                    if String.length value < requestMinInputLength then
                                        ( Model.setSuggestions [] model_, Cmd.none )

                                    else
                                        ( model_, Cmd.none )
                            in
                            andThen maybeClearSuggestions

                        Nothing ->
                            if not (Model.isSuggestionsEmpty model) && not isSuggestionsExpanded then
                                andThen (showSuggestions Nothing)

                            else
                                andThen (\updatedModel -> ( updatedModel, Cmd.none ))
                   )
                |> andThen (debounce (InsertedValueDebounced suggestionToInputValue value |> wrapMsg))

        InsertedValueDebounced suggestionToInputValue value ->
            (case remoteSuggestions of
                Just { requestCmd, requestMinInputLength } ->
                    if value == Model.getInputValue model && (Model.getInputLength model >= requestMinInputLength) then
                        ( model, requestCmd value (GotRequestResponse >> wrapMsg) )

                    else
                        ( model, Cmd.none )

                Nothing ->
                    if value == Model.getInputValue model then
                        let
                            filteredSuggestions =
                                Model.getSuggestions model
                                    |> List.filter
                                        (\suggestion ->
                                            String.contains (String.toLower value) (String.toLower (suggestionToInputValue suggestion))
                                        )
                        in
                        ( Model.setFilteredSuggestions filteredSuggestions model, Cmd.none )

                    else
                        ( model, Cmd.none )
            )
                |> andThen resetHighlight

        GotRequestResponse response ->
            response
                |> RemoteData.map
                    (\suggestionsList ->
                        ( Model.setSuggestions suggestionsList model, Cmd.none )
                            |> andThen
                                (if List.isEmpty suggestionsList then
                                    hideSuggestions

                                 else
                                    showSuggestions remoteSuggestions
                                )
                    )
                |> RemoteData.withDefault (hideSuggestions model)

        NoUpdate ->
            ( model, Cmd.none )


andThen : (Model a -> ( Model a, Cmd msg )) -> ( Model a, Cmd msg ) -> ( Model a, Cmd msg )
andThen fn ( model, cmd ) =
    let
        ( nextModel, nextCmd ) =
            fn model
    in
    ( nextModel, Cmd.batch [ cmd, nextCmd ] )


hideSuggestions : Model a -> ( Model a, Cmd msg )
hideSuggestions model =
    ( Model.hideSuggestions model, Cmd.none )


showSuggestions : Maybe (RemoteSuggestionsPayload a msg) -> Model a -> ( Model a, Cmd msg )
showSuggestions maybeSuggestionsPayload model =
    let
        isSuggestionsEmpty =
            Model.isSuggestionsEmpty model

        shouldShowSuggestions =
            case maybeSuggestionsPayload of
                Just { requestMinInputLength } ->
                    -- If remote suggestions are used, the suggestions are not shown if the input value length is less than `requestMinInputLength`
                    if Model.getInputLength model >= requestMinInputLength then
                        not isSuggestionsEmpty

                    else
                        False

                Nothing ->
                    not isSuggestionsEmpty
    in
    ( if shouldShowSuggestions then
        Model.showSuggestions model

      else
        model
    , Cmd.none
    )


showSuggestionsAndMoveToSelected : (Msg a -> msg) -> Maybe (ScrollSuggestionIntoViewCmd msg) -> Maybe (RemoteSuggestionsPayload a msg) -> Model a -> ( Model a, Cmd msg )
showSuggestionsAndMoveToSelected wrapMsg maybeScrollSuggestionIntoViewCmd maybeSuggestionsPayload model =
    ( model, Cmd.none )
        |> andThen (showSuggestions maybeSuggestionsPayload)
        |> andThen
            (\updatedModel ->
                moveHighlight wrapMsg
                    maybeScrollSuggestionIntoViewCmd
                    (Model.getSelectedSuggestion updatedModel
                        |> Maybe.andThen (\selectedOption -> Model.getFilteredSuggestions model |> List.Extra.findIndex (\option -> option == selectedOption))
                    )
                    updatedModel
            )


resetSuggestions : Model a -> ( Model a, Cmd msg )
resetSuggestions model =
    ( Model.deselectSuggestion model |> Model.resetFilteredSuggestions, Cmd.none )


clearSelectedSuggestion : Model a -> ( Model a, Cmd msg )
clearSelectedSuggestion model =
    ( Model.deselectSuggestion model, Cmd.none )


resetHighlight : Model a -> ( Model a, Cmd msg )
resetHighlight model =
    ( Model.resetHighlight model, Cmd.none )


selectSuggestion : Maybe (a -> msg) -> Maybe a -> (a -> String) -> Model a -> ( Model a, Cmd msg )
selectSuggestion onSelect maybeSuggestion suggestionToInputValue model =
    let
        ( updatedModel, cmd ) =
            case maybeSuggestion of
                Just suggestion ->
                    ( model
                        |> Model.setSelectedSuggestion suggestion
                        |> Model.setInputValue (suggestionToInputValue suggestion)
                    , maybeTriggerParentMsg onSelect suggestion
                    )

                Nothing ->
                    ( model, Cmd.none )
    in
    ( updatedModel, cmd )


updateInputValue : Maybe (String -> msg) -> String -> Model a -> ( Model a, Cmd msg )
updateInputValue onInput value model =
    ( Model.setInputValue value model, maybeTriggerParentMsg onInput value )


debounce : msg -> Model a -> ( Model a, Cmd msg )
debounce msg model =
    ( model
    , Process.sleep 300
        |> Task.perform (\_ -> msg)
    )


moveHighlight : (Msg a -> msg) -> Maybe (ScrollSuggestionIntoViewCmd msg) -> Maybe Int -> Model a -> ( Model a, Cmd msg )
moveHighlight wrapMsg maybeScrollSuggestionIntoViewCmd maybeIndex model =
    let
        scrollSuggestionIntoViewCmd =
            case maybeScrollSuggestionIntoViewCmd of
                Just scrollSuggestionIntoViewCmd_ ->
                    maybeIndex
                        |> Maybe.map (Model.getListboxOptionId model >> scrollSuggestionIntoViewCmd_)
                        |> Maybe.withDefault Cmd.none

                Nothing ->
                    getElementsAndScrollMenu wrapMsg model maybeIndex
    in
    ( Model.moveHighlight maybeIndex model, scrollSuggestionIntoViewCmd )


moveHighlightDown : (Msg a -> msg) -> Maybe (ScrollSuggestionIntoViewCmd msg) -> Model a -> ( Model a, Cmd msg )
moveHighlightDown wrapMsg maybeScrollSuggestionIntoViewCmd model =
    moveHighlight
        wrapMsg
        maybeScrollSuggestionIntoViewCmd
        (Just (Basics.min (List.length (Model.getFilteredSuggestions model) - 1) (Maybe.withDefault -1 (Model.getMaybeHighlightedIndex model) + 1)))
        model


moveHighlightUp : (Msg a -> msg) -> Maybe (ScrollSuggestionIntoViewCmd msg) -> Model a -> ( Model a, Cmd msg )
moveHighlightUp wrapMsg maybeScrollSuggestionIntoViewCmd model =
    moveHighlight
        wrapMsg
        maybeScrollSuggestionIntoViewCmd
        (Just (Basics.max 0 (Maybe.withDefault 0 (Model.getMaybeHighlightedIndex model) - 1)))
        model


getHighlightedOption : Model a -> Maybe a
getHighlightedOption model =
    Model.getMaybeHighlightedIndex model |> Maybe.andThen (\index -> Model.getFilteredSuggestions model |> List.Extra.getAt index)


maybeTriggerParentMsg : Maybe (value -> msg) -> value -> Cmd msg
maybeTriggerParentMsg maybeMsg value =
    case maybeMsg of
        Just msg ->
            Task.succeed ()
                |> Task.perform (\_ -> msg value)

        Nothing ->
            Cmd.none


getElementsAndScrollMenu : (Msg a -> msg) -> Model a -> Maybe Int -> Cmd msg
getElementsAndScrollMenu wrapMsg model maybeIndex =
    case maybeIndex of
        Just index ->
            let
                menuId =
                    Model.getListboxId model

                optionId =
                    Model.getListboxOptionId model index
            in
            Task.map3
                (\option menu menuViewport ->
                    { option = option
                    , menu = menu
                    , menuViewport = menuViewport
                    }
                )
                (Dom.getElement optionId)
                (Dom.getElement menuId)
                (Dom.getViewportOf menuId)
                |> Task.andThen (scrollMenuTask menuId)
                |> Task.attempt (\_ -> wrapMsg NoUpdate)

        Nothing ->
            Cmd.none


scrollMenuTask : String -> { option : Dom.Element, menu : Dom.Element, menuViewport : Dom.Viewport } -> Task.Task Dom.Error ()
scrollMenuTask id { option, menu, menuViewport } =
    calculateScrollTop
        { optionTop = option.element.y - menu.element.y + menuViewport.viewport.y
        , optionBottom =
            (option.element.y - menu.element.y + menuViewport.viewport.y)
                + option.element.height
        , menuViewPortY = menuViewport.viewport.y
        , menuHeight = menu.element.height
        }
        |> Dom.setViewportOf id 0


calculateScrollTop : { optionTop : Float, optionBottom : Float, menuViewPortY : Float, menuHeight : Float } -> Float
calculateScrollTop { optionTop, optionBottom, menuViewPortY, menuHeight } =
    if optionBottom > (menuHeight + menuViewPortY - 10) then
        optionBottom - menuHeight + 10

    else if optionTop < menuViewPortY + 10 then
        optionTop - 10

    else
        menuViewPortY
