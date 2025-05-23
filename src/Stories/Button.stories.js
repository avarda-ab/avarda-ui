import { Elm } from "./Button.elm";

export default {
  title: "Button",
  argTypes: { label: { control: "text" } },
};

export const Button = (controls) => {
  console.log(controls);
  const node = document.createElement("div");
  window.requestAnimationFrame(() => {
    Elm.Stories.Button.init({ node, flags: controls });
  });
  return node;
};
