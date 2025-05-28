import { createElmStory } from "../../.storybook/util";
import { Elm } from "./Input.elm";

export const Input = () => createElmStory(Elm.Stories.Input, null);

export default {
  title: "Input",
};
