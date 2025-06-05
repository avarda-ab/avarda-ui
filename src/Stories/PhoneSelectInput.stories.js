import { createElmStory } from "../../.storybook/util";
import { Elm } from "./PhoneSelectInput.elm";

export const PhoneSelectInput = (controls) =>
  createElmStory(Elm.Stories.PhoneSelectInput, controls);

export default {
  title: "Stories/PhoneSelectInput",
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
    withMaxHeight: {
      name: "With menu max height",
      control: "boolean",
    },
    maxHeight: {
      name: "Max height",
      control: "number",
      if: { arg: "withMaxHeight" },
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
  },
  args: {
    label: "Test phone input",
    withPlaceholder: false,
    placeholder: "",
    withHint: false,
    hint: "",
    withError: false,
    error: "",
    withMaxHeight: false,
    maxHeight: 0,
    required: false,
    disabled: false,
  },
};
