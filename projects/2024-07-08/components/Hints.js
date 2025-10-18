import React from "react";
import { useKeyState } from "../lib/dynamicStore.js";
import { Messages } from "../lib/messages.js";
import { ClassNames } from "../lib/classNames.js";
import { useSaveStore } from "../lib/saveStore.js";

const HintButton = ({ hintsUsed, length, onClick }) => {
  return React.createElement(
    "button",
    {
      className: ClassNames.ButtonSmall,
      onClick,
      type: "button",
    },
    `${Messages.Hint} (${length - hintsUsed} ${Messages.HintsRemaining})`
  );
};

export const Hints = ({ hints, schema }) => {
  const [hintsUsed, setHintsUsed] = useKeyState(useSaveStore)(schema.hintsUsed);

  const hintChildren = hints.slice(0, hintsUsed).map((h) =>
    React.createElement("li", {
      dangerouslySetInnerHTML: {
        __html: h,
      },
    })
  );
  return React.createElement(
    "div",
    null,
    hintsUsed === hints.length
      ? null
      : React.createElement(HintButton, {
          hintsUsed,
          length: hints.length,
          onClick: () => setHintsUsed(hintsUsed + 1),
        }),
    hintChildren.length === 0
      ? null
      : React.createElement("h3", null, Messages.Hints),
    React.createElement("ul", null, ...hintChildren)
  );
};
