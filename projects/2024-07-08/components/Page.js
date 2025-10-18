import React from "react";
import { ClassNames } from "../lib/classNames.js";
import { Messages } from "../lib/messages.js";
import { PuzzleSwitch } from "./PuzzleSwitch.js";
import { ObfuscatedImage } from "./ObfuscatedImage.js";

const PageHeader = ({ index, length }) => {
  const text = `${Messages.PageNumber} ${index + 1} / ${length}`;
  return React.createElement("h2", null, text);
};

export const Page = ({ index, length, page }) => {
  return React.createElement(
    "section",
    {
      className: ClassNames.Page,
    },
    React.createElement(PageHeader, {
      index,
      length,
    }),
    React.createElement(ObfuscatedImage, {
      src: page.data.imgsrc,
    }),
    React.createElement(PuzzleSwitch, {
      correct: page.data.correct,
      puzzle: page.puzzle,
      schema: page.schema,
    })
  );
};
