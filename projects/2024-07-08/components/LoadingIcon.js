import React from "react";
import { ClassNames } from "../lib/classNames.js";

export const LoadingIcon = () => {
  return React.createElement("img", {
    className: ClassNames.LoadingIcon,
    src: "./images/loading.png",
  });
};
