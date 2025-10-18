import React from "react";
import { ClassNames } from "../lib/classNames.js";
import { Messages } from "../lib/messages.js";
import { PuzzleCorrect } from "./PuzzleCorrect.js";
import { PuzzleSubmit } from "./PuzzleSubmit.js";
import { FormState } from "../lib/formState.js";

export const TextForm = ({
  correct,
  expected,
  onChange,
  onSolve,
  prefix,
  solved,
  suffix,
  value,
}) => {
  const [attempted, setAttempted] = React.useState(false);

  const handleChange = React.useCallback((e) => {
    onChange(e.target.value);
  });
  const handleSubmit = React.useCallback(
    (e) => {
      e.preventDefault();

      setAttempted(true);

      const normalized = value
        .trim()
        .replace(/[\p{P}\p{S}]/gu, "")
        .toLowerCase();

      if (expected.includes(normalized)) {
        onSolve();
      }
    },
    [expected, onSolve, setAttempted, value]
  );

  return React.createElement(
    "form",
    {
      className: ClassNames.PuzzleForm,
      onSubmit: handleSubmit,
    },
    React.createElement(
      "fieldset",
      {
        className: ClassNames.PuzzleFieldset,
        disabled: solved,
      },
      React.createElement(
        "span",
        {
          className: ClassNames.PuzzleInputPrefix,
        },
        prefix
      ),
      React.createElement("input", {
        className: ClassNames.PuzzleInputText,
        disabled: solved,
        maxLength: 2 ** 5,
        onChange: handleChange,
        placeholder: Messages.TextPlaceholder,
        type: "text",
        value,
      }),
      React.createElement(
        "span",
        {
          className: ClassNames.PuzzleInputSuffix,
        },
        suffix
      )
    ),
    solved
      ? React.createElement(PuzzleCorrect, {
          correct,
        })
      : React.createElement(PuzzleSubmit, {
          formState: attempted ? FormState.Incorrect : FormState.Unsubmitted,
        })
  );
};
