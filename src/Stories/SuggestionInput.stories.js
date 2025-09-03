import { createElmStory } from "../../.storybook/util";
import { Elm } from "./SuggestionInput.elm";

export const SuggestionInput = (controls) => {
  return createElmStory(Elm.Stories.SuggestionInput, controls);
};

export default {
  title: "Stories/SuggestionInput",
  argTypes: {
    label: {
      type: { required: true },
      name: "Label",
      control: "text",
    },
    withPlaceholder: { name: "With placeholder", control: "boolean" },
    placeholder: {
      name: "Placeholder",
      control: "text",
      if: { arg: "withPlaceholder" },
    },
    withHint: { name: "With hint", control: "boolean" },
    hint: {
      name: "Hint",
      control: "text",
      if: { arg: "withHint" },
    },
    withError: { name: "With error", control: "boolean" },
    error: {
      name: "Error",
      control: "text",
      if: { arg: "withError" },
    },
    required: {
      defaultValue: { summary: "false" },
      name: "Required",
      control: "boolean",
    },
    disabled: {
      defaultValue: { summary: "false" },
      name: "Disabled",
      control: "boolean",
    },
    showIconLeft: {
      defaultValue: { summary: "false" },
      name: "Show icon left",
      control: "boolean",
    },
    showIconRight: {
      defaultValue: { summary: "false" },
      name: "Show icon right",
      control: "boolean",
    },
    withMaxMenuHeight: { name: "With max menu height", control: "boolean" },
    maxMenuHeight: {
      name: "Max height",
      control: "number",
      if: { arg: "withMaxMenuHeight" },
    },
  },
  args: {
    label: "Test suggestion input",
    withPlaceholder: false,
    placeholder: "",
    withHint: false,
    hint: "",
    withError: false,
    error: "",
    required: false,
    disabled: false,
    showIconLeft: false,
    showIconRight: false,
    withMaxMenuHeight: false,
    maxMenuHeight: "",
  },
};
