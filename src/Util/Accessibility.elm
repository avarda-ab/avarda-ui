module Util.Accessibility exposing
    ( ariaActiveDescendant
    , ariaControls
    , ariaDescribedBy
    , ariaDescribedByList
    , ariaDisabled
    , ariaExpanded
    , ariaHasPopup
    , ariaHidden
    , ariaInvalid
    , ariaLabel
    , ariaLabelledBy
    , ariaRequired
    , ariaSelected
    , requiredAsterisk
    , role
    )

import Css
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attributes


ariaSelected : Bool -> Attribute a
ariaSelected =
    boolToString >> Attributes.attribute "aria-selected"


ariaRequired : Bool -> Attribute a
ariaRequired =
    boolToString >> Attributes.attribute "aria-required"


ariaDisabled : Bool -> Attribute a
ariaDisabled =
    boolToString >> Attributes.attribute "aria-disabled"


ariaControls : String -> Attribute a
ariaControls =
    Attributes.attribute "aria-controls"


ariaHasPopup : String -> Attribute a
ariaHasPopup =
    Attributes.attribute "aria-haspopup"


ariaExpanded : Bool -> Attribute a
ariaExpanded =
    boolToString >> Attributes.attribute "aria-expanded"


ariaActiveDescendant : String -> Attribute a
ariaActiveDescendant =
    Attributes.attribute "aria-activedescendant"


role : String -> Attribute a
role =
    Attributes.attribute "role"


ariaLabel : String -> Attribute a
ariaLabel =
    Attributes.attribute "aria-label"


ariaLabelledBy : String -> Attribute a
ariaLabelledBy =
    Attributes.attribute "aria-labelledby"


ariaInvalid : Bool -> Attribute a
ariaInvalid =
    boolToString >> Attributes.attribute "aria-invalid"


ariaHidden : Attribute a
ariaHidden =
    Attributes.attribute "aria-hidden" "true"


ariaDescribedBy : String -> Attribute a
ariaDescribedBy elementId =
    Attributes.attribute "aria-describedby" elementId


ariaDescribedByList : List String -> Attribute a
ariaDescribedByList =
    String.join " " >> Attributes.attribute "aria-describedby"


requiredAsterisk : Bool -> Html msg
requiredAsterisk isRequired =
    if isRequired then
        Html.span
            [ Attributes.css
                [ Css.color (Css.hex "#BB0E15") ]
            , ariaHidden
            ]
            [ Html.text "*\u{00A0}" ]

    else
        Html.text ""


boolToString : Bool -> String
boolToString bool =
    if bool then
        "true"

    else
        "false"
