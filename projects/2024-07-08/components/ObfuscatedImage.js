import React from "react";
import { useKeyState } from "../lib/dynamicStore.js";
import { useImageStore } from "../lib/imageStore.js";
import { ClassNames } from "../lib/classNames.js";
import { LoadingIcon } from "./LoadingIcon.js";

export const ObfuscatedImage = ({ src }) => {
  const [url] = useKeyState(useImageStore)({
    defaultValue: "",
    key: src,
  });

  return url === ""
    ? React.createElement(
        "div",
        {
          className: ClassNames.LoadingCell,
        },
        React.createElement(LoadingIcon)
      )
    : React.createElement("img", {
        className: ClassNames.PageImage,
        src: url,
      });
};
