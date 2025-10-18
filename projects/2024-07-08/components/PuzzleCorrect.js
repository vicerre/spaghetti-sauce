import React from "react";
import { CorrectType } from "../lib/correctType.js";
import { ClassNames } from "../lib/classNames.js";
import { ObfuscatedImage } from "./ObfuscatedImage.js";

export const PuzzleCorrect = ({ correct }) => {
  switch (correct.type) {
    case CorrectType.Boom: {
      return React.createElement("hr", {
        className: [
          ClassNames.PuzzleCorrect,
          ClassNames.PuzzleCorrectBoom,
        ].join(" "),
      });
    }
    case CorrectType.EmojiSpam: {
      return React.createElement("hr", {
        className: [
          ClassNames.PuzzleCorrect,
          ClassNames.PuzzleCorrectEmojiStorm,
        ].join(" "),
      });
    }
    case CorrectType.Image: {
      return React.createElement(
        "div",
        {
          className: ClassNames.PuzzleCorrect,
        },
        React.createElement(ObfuscatedImage, {
          src: correct.imgsrc,
        })
      );
    }
    default: {
      throw new Error(`Unexpected correct type: ${correct.type}`);
    }
  }
};
