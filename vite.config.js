import { defineConfig } from "vite";
import plugin from "vite-plugin-elm";

export default defineConfig(({ mode }) => {
  const [debug, optimize] = mode === "dev" ? [true, false] : [false, true];
  return {
    plugins: [
      plugin({
        nodeElmCompilerOptions: {
          debug: true,
          optimize: false,
        },
      }),
    ],
    root: ".",
  };
});
