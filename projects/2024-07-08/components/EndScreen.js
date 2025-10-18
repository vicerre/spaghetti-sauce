import React from "react";
import { Messages } from "../lib/messages.js";

export const EndScreen = ({ hintsTotal, hintsUsed }) => {
  return React.createElement(
    "div",
    null,
    React.createElement(
      "p",
      null,
      `${Messages.HintsUsed} ${hintsUsed} / ${hintsTotal}`
    )
  );
};
