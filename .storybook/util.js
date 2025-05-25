export const createElmStory = (elmModule, controls) => {
  const node = document.createElement("div");
  window.requestAnimationFrame(() => {
    elmModule.init({
      node,
      flags: controls,
    });
  });
  return node;
};
