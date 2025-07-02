import { createElmStory } from "../../.storybook/util";
import { Elm } from "./SelectNative.elm";

export const SelectNative = (controls) => {
  return createElmStory(Elm.Stories.SelectNative, controls);
};

export default {
  title: "Stories/SelectNative",
  argTypes: {
    label: {
      type: { required: true },
      name: "Label",
      control: "text",
    },
    placeholderOption: {
      type: { required: true },
      name: "Placeholder option",
      control: "text",
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
  },
  args: {
    label: "Test select",
    placeholderOption: "Placeholder option",
    withError: false,
    error: "",
    required: false,
    disabled: false,
  },
};
