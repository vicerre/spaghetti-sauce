import _ from "lodash";
import React from "react";
import { Page } from "./Page.js";
import { ClassNames } from "../lib/classNames.js";
import { selectAggregate } from "../lib/dynamicStore.js";
import { EndScreen } from "./EndScreen.js";
import { useSaveStore } from "../lib/saveStore.js";
import { DebugSettings } from "../lib/debugSettings.js";

export const Pages = ({ pages }) => {
  const hintsTotal = React.useMemo(() => {
    const hintLengths = pages.map((p) => p.puzzle.hints.length);
    return _.sum(hintLengths);
  }, pages);
  const hintsUsedSchemata = React.useMemo(
    () => pages.map((p) => p.schema.hintsUsed),
    pages
  );
  const solvedSchemata = React.useMemo(
    () => pages.map((p) => p.schema.solved),
    pages
  );
  const hintsUsed = useSaveStore(selectAggregate(hintsUsedSchemata, _.sum));
  const nextIndex =
    DebugSettings.nextIndex ??
    useSaveStore(
      selectAggregate(
        solvedSchemata,
        (values) => _.takeWhile(values).length + 1
      )
    );

  const pageChildren = pages.slice(0, nextIndex).map((page, i) =>
    React.createElement(Page, {
      index: i,
      key: i,
      length: pages.length,
      page,
    })
  );

  return React.createElement(
    "div",
    null,
    React.createElement(
      "div",
      {
        className: ClassNames.Pages,
      },
      ...pageChildren
    ),
    nextIndex === pages.length + 1
      ? React.createElement(
          "div",
          null,
          React.createElement(EndScreen, {
            hintsTotal,
            hintsUsed,
          })
        )
      : null
  );
};
