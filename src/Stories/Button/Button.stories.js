import { createElmStory } from "../../../.storybook/util";
import { Elm as PrimaryElm } from "./Primary.elm";
import { Elm as SecondaryElm } from "./Secondary.elm";
import { Elm as TertiaryElm } from "./Tertiary.elm";

export const Primary = (controls) =>
  createElmStory(PrimaryElm.Stories.Button.Primary, controls);

export const Secondary = (controls) =>
  createElmStory(SecondaryElm.Stories.Button.Secondary, controls);

export const Tertiary = (controls) =>
  createElmStory(TertiaryElm.Stories.Button.Tertiary, controls);

export default {
  argTypes: {
    label: {
      type: { required: true },
      name: "Button label",
      control: "text",
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
    size: {
      defaultValue: { summary: "medium" },
      type: { name: "medium | small | xsmall" },
      name: "Size",
      control: { type: "select" },
      options: ["medium", "small", "xsmall"],
    },
  },
  args: {
    label: "Click me",
    disabled: false,
    showIconLeft: false,
    showIconRight: false,
    size: "medium",
  },
};
