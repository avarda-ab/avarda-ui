# Avarda UI – Design System for Elm

A collection of Elm components implementing the Avarda design system.  
This package provides accessible, styled UI primitives such as inputs, buttons, and layout utilities, designed for consistency across applications.

All components use the **builder pattern**:

- Start with `new` to create a base component.
- Chain configuration functions (`withX`) to customize behavior.
- Render with `view`.

---

## Philosophy

- **Consistency** – Components follow Avarda design guidelines.
- **Accessibility** – Every component is keyboard and screen reader friendly.
- **Elm-friendly API** – Builder pattern ensures immutability and composability.
