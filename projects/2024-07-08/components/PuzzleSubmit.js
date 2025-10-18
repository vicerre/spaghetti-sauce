import React from "react";
import { ClassNames } from "../lib/classNames.js";
import { Messages } from "../lib/messages.js";
import { FormState } from "../lib/formState.js";

export const PuzzleSubmit = ({ formState }) => {
  const ref = React.useRef(null);

  // https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_animations/Tips
  // https://stackoverflow.com/questions/6268508/
  const restartAnimation = React.useCallback(() => {
    ref.current.style.animation = "none";
    ref.current.offsetHeight; // trigger reflow
    ref.current.style.animation = null;
  }, [ref.current]);

  return React.createElement(
    "button",
    {
      className: [
        ClassNames.ButtonSubmit,
        ...(formState === FormState.Incorrect
          ? [ClassNames.ButtonSubmitIncorrect]
          : []),
      ].join(" "),
      onClick: restartAnimation,
      ref,
      type: "submit",
    },
    Messages.Submit
  );
};
