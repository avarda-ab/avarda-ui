module AvardaUi.SelectInternal.Model exposing (Model, closeSelect, getComboboxId, getErrorId, getIsOpen, getLabelId, getListboxId, getListboxOptionId, getMaybeHighlightedIndex, getSelectedOption, init, moveHighlight, openSelect, setSelectedOption)


type Model a
    = ModelInternal
        { id : String
        , isOpen : Bool
        , selectedOption : Maybe a
        , maybeError : Maybe String
        , maybeHighlightedIndex : Maybe Int
        }


init : String -> Model a
init id =
    ModelInternal
        { id = id
        , isOpen = False
        , selectedOption = Nothing
        , maybeHighlightedIndex = Nothing
        , maybeError = Nothing
        }


setSelectedOption : a -> Model a -> Model a
setSelectedOption option (ModelInternal model) =
    ModelInternal { model | selectedOption = Just option }


getSelectedOption : Model a -> Maybe a
getSelectedOption (ModelInternal { selectedOption }) =
    selectedOption


getMaybeHighlightedIndex : Model a -> Maybe Int
getMaybeHighlightedIndex (ModelInternal { maybeHighlightedIndex }) =
    maybeHighlightedIndex


getIsOpen : Model a -> Bool
getIsOpen (ModelInternal { isOpen }) =
    isOpen


moveHighlight : Maybe Int -> Model a -> Model a
moveHighlight maybeIndex (ModelInternal model) =
    ModelInternal { model | maybeHighlightedIndex = maybeIndex }


closeSelect : Model a -> Model a
closeSelect (ModelInternal model) =
    ModelInternal { model | isOpen = False, maybeHighlightedIndex = Nothing }


openSelect : Model a -> Model a
openSelect (ModelInternal model) =
    ModelInternal { model | isOpen = True }



-- Ids


getListboxId : Model a -> String
getListboxId (ModelInternal { id }) =
    "avd-select-" ++ id ++ "-listbox"


getComboboxId : Model a -> String
getComboboxId (ModelInternal { id }) =
    "avd-select-" ++ id ++ "-combobox"


getListboxOptionId : Model a -> Int -> String
getListboxOptionId (ModelInternal { id }) index =
    "avd-select-" ++ id ++ "-listbox-item-" ++ String.fromInt index


getLabelId : Model a -> String
getLabelId (ModelInternal { id }) =
    "avd-select-" ++ id ++ "-label"


getErrorId : Model a -> String
getErrorId (ModelInternal { id }) =
    "avd-select-" ++ id ++ "-error"
