import { createElmStory } from "../../.storybook/util";
import { Elm } from "./PhoneSelectInput.elm";

export const PhoneSelectInput = () =>
  createElmStory(Elm.Stories.PhoneSelectInput, null);

export default {
  title: "PhoneSelectInput",
};
