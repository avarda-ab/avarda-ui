import { createElmStory } from "../../.storybook/util";
import { Elm } from "./Select.elm";

export const Select = (controls) =>
  createElmStory(Elm.Stories.Select, controls);

export default {
  title: "Stories/Select",
  argTypes: {
    label: {
      type: { required: true },
      name: "Label",
      control: "text",
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
    label: "Test select",
    withError: false,
    error: "",
    withMaxHeight: false,
    maxHeight: 0,
    required: false,
    disabled: false,
  },
};
