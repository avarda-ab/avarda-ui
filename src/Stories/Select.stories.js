import { createElmStory } from "../../.storybook/util";
import { Elm } from "./Select.elm";

export const Select = () => createElmStory(Elm.Stories.Select, null);

export default {
  title: "Select",
};
