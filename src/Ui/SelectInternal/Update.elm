module Ui.SelectInternal.Update exposing (Callback(..), Callbacks, ScrollOptionIntoViewCmd, update, updateWithCallbacks)

import Browser.Dom as Dom
import List.Extra
import Task
import Ui.SelectInternal.Model as Model exposing (Model)
import Ui.SelectInternal.Msg exposing (Msg(..))


type Callback a msg
    = OnSelect (a -> msg)
    | ScrollOptionIntoView (ScrollOptionIntoViewCmd msg)


type alias Callbacks a msg =
    { onSelect : Maybe (a -> msg)
    , scrollOptionIntoViewCmd : Maybe (ScrollOptionIntoViewCmd msg)
    }


type alias ScrollOptionIntoViewCmd msg =
    String -> Cmd msg


defaultCallbacks : Callbacks a msg
defaultCallbacks =
    { onSelect = Nothing, scrollOptionIntoViewCmd = Nothing }


callbacksFromList : List (Callback a msg) -> Callbacks a msg
callbacksFromList =
    List.foldl
        (\opt opts ->
            case opt of
                OnSelect msg ->
                    { opts | onSelect = Just msg }

                ScrollOptionIntoView scrollOptionIntoViewCmd ->
                    { opts | scrollOptionIntoViewCmd = Just scrollOptionIntoViewCmd }
        )
        defaultCallbacks


update : (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
update =
    updateRaw (callbacksFromList [])


updateWithCallbacks : List (Callback a msg) -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateWithCallbacks callbackList =
    updateRaw (callbacksFromList callbackList)


updateRaw : Callbacks a msg -> (Msg a -> msg) -> Msg a -> Model a -> ( Model a, Cmd msg )
updateRaw { onSelect, scrollOptionIntoViewCmd } wrapMsg msg model =
    let
        isSelectOpened =
            Model.getIsOpen model
    in
    case msg of
        HandleEnterOrSpace optionList ->
            if isSelectOpened then
                ( model, Cmd.none )
                    |> andThen (selectOption onSelect (getHighlightedOption model optionList))
                    |> andThen closeSelect

            else
                ( model, Cmd.none )
                    |> andThen openSelect
                    |> andThen (\updatedModel -> moveHighlight wrapMsg scrollOptionIntoViewCmd (Model.getSelectedOption updatedModel |> Maybe.andThen (\selectedOption -> optionList |> List.Extra.findIndex (\option -> option == selectedOption))) updatedModel)

        Close ->
            ( model, Cmd.none )
                |> andThen closeSelect

        Toggle optionList ->
            if Model.getIsOpen model then
                ( model, Cmd.none )
                    |> andThen closeSelect

            else
                ( model, Cmd.none )
                    |> andThen openSelect
                    |> andThen (\updatedModel -> moveHighlight wrapMsg scrollOptionIntoViewCmd (Model.getSelectedOption updatedModel |> Maybe.andThen (\selectedOption -> optionList |> List.Extra.findIndex (\option -> option == selectedOption))) updatedModel)

        Select option ->
            ( model, Cmd.none )
                |> andThen (selectOption onSelect (Just option))
                |> andThen closeSelect

        HandleArrowDown optionList ->
            if isSelectOpened then
                ( model, Cmd.none )
                    |> andThen (moveHighlight wrapMsg scrollOptionIntoViewCmd (Just (Basics.min (List.length optionList - 1) (Maybe.withDefault -1 (Model.getMaybeHighlightedIndex model) + 1))))

            else
                ( model, Cmd.none )
                    |> andThen openSelect
                    |> andThen (\updatedModel -> moveHighlight wrapMsg scrollOptionIntoViewCmd (Model.getSelectedOption updatedModel |> Maybe.andThen (\selectedOption -> optionList |> List.Extra.findIndex (\option -> option == selectedOption))) updatedModel)

        HandleArrowUp ->
            if isSelectOpened then
                ( model, Cmd.none )
                    |> andThen (moveHighlight wrapMsg scrollOptionIntoViewCmd (Just (Basics.max 0 (Maybe.withDefault 0 (Model.getMaybeHighlightedIndex model) - 1))))

            else
                ( model, Cmd.none )
                    |> andThen openSelect
                    |> andThen (moveHighlight wrapMsg scrollOptionIntoViewCmd (Just 0))

        HandleOnBlur optionList ->
            if isSelectOpened then
                ( model, Cmd.none )
                    |> andThen (selectOption onSelect (getHighlightedOption model optionList))
                    |> andThen closeSelect

            else
                ( model, Cmd.none )
                    |> andThen closeSelect

        NoUpdate ->
            ( model, Cmd.none )


andThen : (Model a -> ( Model a, Cmd msg )) -> ( Model a, Cmd msg ) -> ( Model a, Cmd msg )
andThen fn ( model, cmd ) =
    let
        ( nextModel, nextCmd ) =
            fn model
    in
    ( nextModel, Cmd.batch [ cmd, nextCmd ] )


closeSelect : Model a -> ( Model a, Cmd msg )
closeSelect model =
    ( Model.closeSelect model, Cmd.none )


openSelect : Model a -> ( Model a, Cmd msg )
openSelect model =
    ( Model.openSelect model, Cmd.none )


selectOption : Maybe (a -> msg) -> Maybe a -> Model a -> ( Model a, Cmd msg )
selectOption onSelect maybeOption model =
    let
        ( updatedModel, cmd ) =
            case maybeOption of
                Just option ->
                    ( Model.setSelectedOption option model
                    , maybeTriggerParentMsg onSelect option
                    )

                Nothing ->
                    ( model, Cmd.none )
    in
    ( updatedModel, cmd )


moveHighlight : (Msg a -> msg) -> Maybe (ScrollOptionIntoViewCmd msg) -> Maybe Int -> Model a -> ( Model a, Cmd msg )
moveHighlight wrapMsg maybeScrollOptionIntoViewCmd maybeIndex model =
    let
        scrollOptionIntoViewCmd =
            case maybeScrollOptionIntoViewCmd of
                Just scrollOptionntoViewCmd_ ->
                    maybeIndex
                        |> Maybe.map (Model.getListboxOptionId model >> scrollOptionntoViewCmd_)
                        |> Maybe.withDefault Cmd.none

                Nothing ->
                    getElementsAndScrollMenu wrapMsg model maybeIndex
    in
    ( Model.moveHighlight maybeIndex model, scrollOptionIntoViewCmd )


getHighlightedOption : Model a -> List a -> Maybe a
getHighlightedOption model optionList =
    Model.getMaybeHighlightedIndex model |> Maybe.andThen (\index -> optionList |> List.Extra.getAt index)


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
