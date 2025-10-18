import React from "react";
import { PuzzleType } from "../lib/puzzleType.js";
import { MultiDigitForm } from "./MultiDigitForm.js";
import { useKeyState } from "../lib/dynamicStore.js";
import { TextForm } from "./TextForm.js";
import { Hints } from "./Hints.js";
import { ClassNames } from "../lib/classNames.js";
import { useSaveStore } from "../lib/saveStore.js";

export const PuzzleSwitch = ({ correct, puzzle, schema }) => {
  const [value, setValue] = useKeyState(useSaveStore)(schema.input);
  const [solved, setSolved] = useKeyState(useSaveStore)(schema.solved);

  let form;
  switch (puzzle.type) {
    case PuzzleType.MultiDigit: {
      form = React.createElement(MultiDigitForm, {
        correct,
        expected: puzzle.expected,
        onChange: setValue,
        onSolve: () => setSolved(true),
        solved,
        suffix: puzzle.suffix,
        value,
      });
      break;
    }
    case PuzzleType.Text: {
      form = React.createElement(TextForm, {
        correct,
        expected: puzzle.expected,
        onChange: setValue,
        onSolve: () => setSolved(true),
        prefix: puzzle.prefix,
        solved,
        suffix: puzzle.suffix,
        value,
      });
      break;
    }
    default: {
      throw new Error(`Unexpected puzzle type: ${puzzle.type}`);
    }
  }

  return React.createElement(
    "div",
    {
      className: ClassNames.Puzzle,
    },
    React.createElement("p", {
      className: ClassNames.PuzzlePrompt,
      dangerouslySetInnerHTML: {
        __html: puzzle.prompt,
      },
    }),
    form,
    solved
      ? null
      : React.createElement(Hints, {
          hints: puzzle.hints,
          schema,
        })
  );
};
