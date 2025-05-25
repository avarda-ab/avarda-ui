import { createElmStory } from "../../../.storybook/util";
import { Elm as PrimaryElm } from "./Primary.elm";
import { Elm as SecondaryElm } from "./Secondary.elm";

export const Primary = (controls) =>
  createElmStory(PrimaryElm.Stories.Button.Primary, controls);

export const Secondary = (controls) =>
  createElmStory(SecondaryElm.Stories.Button.Secondary, controls);

export default {
  argTypes: {
    label: { control: "text" },
    disabled: { control: "boolean" },
    showIconLeft: { control: "boolean" },
    showIconRight: { control: "boolean" },
    size: {
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
