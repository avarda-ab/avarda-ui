module Ui.SuggestionInputInternal.Model exposing (Model, deselectSuggestion, getFilteredSuggestions, getInputId, getInputLength, getInputValue, getIsSuggestionsExpanded, getListboxId, getListboxOptionId, getMaybeHighlightedIndex, getSelectedSuggestion, getSuggestions, hideSuggestions, init, isSuggestionsEmpty, moveHighlight, reinit, resetFilteredSuggestions, resetHighlight, setFilteredSuggestions, setInputValue, setSelectedSuggestion, setSuggestions, showSuggestions)


type Model a
    = ModelInternal
        { id : String
        , isSuggestionsExpanded : Bool
        , selectedSuggestion : Maybe a
        , suggestions : List a
        , filteredSuggestions : List a
        , maybeHighlightedIndex : Maybe Int
        , inputValue : String
        }


init : String -> Model a
init id =
    ModelInternal
        { id = id
        , isSuggestionsExpanded = False
        , selectedSuggestion = Nothing
        , suggestions = []
        , filteredSuggestions = []
        , maybeHighlightedIndex = Nothing
        , inputValue = ""
        }


reinit : Model a -> Model a
reinit (ModelInternal { id }) =
    init id


setSelectedSuggestion : a -> Model a -> Model a
setSelectedSuggestion suggestion (ModelInternal model) =
    ModelInternal { model | selectedSuggestion = Just suggestion }


deselectSuggestion : Model a -> Model a
deselectSuggestion (ModelInternal model) =
    ModelInternal { model | selectedSuggestion = Nothing }


getSelectedSuggestion : Model a -> Maybe a
getSelectedSuggestion (ModelInternal { selectedSuggestion }) =
    selectedSuggestion


getMaybeHighlightedIndex : Model a -> Maybe Int
getMaybeHighlightedIndex (ModelInternal { maybeHighlightedIndex }) =
    maybeHighlightedIndex


getSuggestions : Model a -> List a
getSuggestions (ModelInternal { suggestions }) =
    suggestions


getFilteredSuggestions : Model a -> List a
getFilteredSuggestions (ModelInternal { filteredSuggestions }) =
    filteredSuggestions


getInputValue : Model a -> String
getInputValue (ModelInternal { inputValue }) =
    inputValue


getInputLength : Model a -> Int
getInputLength (ModelInternal { inputValue }) =
    String.length inputValue


getIsSuggestionsExpanded : Model a -> Bool
getIsSuggestionsExpanded (ModelInternal { isSuggestionsExpanded }) =
    isSuggestionsExpanded


moveHighlight : Maybe Int -> Model a -> Model a
moveHighlight maybeIndex (ModelInternal model) =
    ModelInternal { model | maybeHighlightedIndex = maybeIndex }


hideSuggestions : Model a -> Model a
hideSuggestions (ModelInternal model) =
    ModelInternal { model | isSuggestionsExpanded = False, maybeHighlightedIndex = Nothing }


showSuggestions : Model a -> Model a
showSuggestions (ModelInternal model) =
    ModelInternal { model | isSuggestionsExpanded = True }


setSuggestions : List a -> Model a -> Model a
setSuggestions suggestions (ModelInternal model) =
    ModelInternal { model | suggestions = suggestions, filteredSuggestions = suggestions }


setFilteredSuggestions : List a -> Model a -> Model a
setFilteredSuggestions filteredSuggestions (ModelInternal model) =
    ModelInternal { model | filteredSuggestions = filteredSuggestions }


resetFilteredSuggestions : Model a -> Model a
resetFilteredSuggestions (ModelInternal model) =
    ModelInternal { model | filteredSuggestions = model.suggestions }


resetHighlight : Model a -> Model a
resetHighlight (ModelInternal model) =
    ModelInternal { model | maybeHighlightedIndex = Nothing }


setInputValue : String -> Model a -> Model a
setInputValue value (ModelInternal model) =
    ModelInternal { model | inputValue = value }


isSuggestionsEmpty : Model a -> Bool
isSuggestionsEmpty (ModelInternal { suggestions }) =
    List.isEmpty suggestions



-- Ids


baseId : String
baseId =
    "avd-suggestion_input-"


getInputId : Model a -> String
getInputId (ModelInternal { id }) =
    baseId ++ id


getListboxId : Model a -> String
getListboxId (ModelInternal { id }) =
    baseId ++ id ++ "-listbox"


getListboxOptionId : Model a -> Int -> String
getListboxOptionId (ModelInternal { id }) index =
    baseId ++ id ++ "-listbox-item-" ++ String.fromInt index
