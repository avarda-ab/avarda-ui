import { createElmStory } from "../../.storybook/util";
import { Elm } from "./Input.elm";

export const Input = (controls) => {
  console.log(controls);
  return createElmStory(Elm.Stories.Input, controls);
};

export default {
  title: "Stories/Input",
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
    withMaxLength: { name: "With max length", control: "boolean" },
    maxLength: {
      defaultValue: { summary: 524288 },
      name: "Max length",
      control: "number",
      if: { arg: "withMaxLength" },
    },
  },
  args: {
    label: "Test input",
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
    withMaxLength: false,
    maxLength: "",
  },
};
