import React from "react";
import _ from "lodash";
import { FormState } from "../lib/formState.js";
import { ClassNames } from "../lib/classNames.js";
import { PuzzleSubmit } from "./PuzzleSubmit.js";
import { PuzzleCorrect } from "./PuzzleCorrect.js";

export const MultiDigitForm = ({
  correct,
  expected,
  onChange,
  onSolve,
  solved,
  suffix,
  value,
}) => {
  const [attempted, setAttempted] = React.useState(false);

  const handleChange = React.useCallback(
    (e, i) => {
      const mod10 = (e.target.valueAsNumber + 10) % 10;
      const changed = [...value.slice(0, i), mod10, ...value.slice(i + 1)];
      onChange(changed);
    },
    [value, onChange]
  );
  const handleSubmit = React.useCallback(
    (e) => {
      e.preventDefault();

      setAttempted(true);

      if (_.isEqual(value, expected)) {
        onSolve();
      }
    },
    [expected, onSolve, setAttempted, value]
  );

  const inputs = value.map((n, i) => {
    return React.createElement("input", {
      className: ClassNames.PuzzleInputDigit,
      disabled: solved,
      key: i,
      max: 9 + 1,
      min: 0 - 1,
      onChange: (e) => handleChange(e, i),
      size: 5,
      type: "number",
      value: n,
    });
  });

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
      ...inputs,
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
