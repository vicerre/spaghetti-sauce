import React from "react";
import { Messages } from "../lib/messages.js";
import { ClassNames } from "../lib/classNames.js";
import { Pages } from "./Pages.js";
import { PAGES, SUMMARY } from "../lib/spoilers.js";
import { useSaveStore } from "../lib/saveStore.js";
import { usePreloadedImages } from "../lib/imageHooks.js";
import { LoadingIcon } from "./LoadingIcon.js";

const Description = ({ summary }) => {
  return React.createElement(
    "div",
    null,
    summary.intro.map((s) => React.createElement("p", null, s)),
    summary.reverseFlow
      ? React.createElement(
          "p",
          {
            className: ClassNames.RtlHint,
          },
          Messages.ReverseFlow
        )
      : null
  );
};

const Header = ({ summary }) => {
  return React.createElement("h1", null, summary.title);
};

const Toolbar = () => {
  const clear = useSaveStore((state) => state.clear);
  const handleReset = React.useCallback(() => {
    if (confirm(Messages.ResetConfirmation)) {
      clear();
      location.reload();
    }
  }, []);

  return React.createElement(
    "nav",
    {
      className: ClassNames.Topbar,
    },
    React.createElement(
      "button",
      {
        className: ClassNames.ButtonSmall,
        onClick: handleReset,
        type: "button",
      },
      Messages.Reset
    )
  );
};

export const App = () => {
  const preloaded = usePreloadedImages(PAGES);

  return React.createElement(
    "div",
    {
      className: ClassNames.Main,
    },
    React.createElement(
      "div",
      {
        className: ClassNames.MainInner,
      },
      React.createElement(Toolbar),
      React.createElement(
        "section",
        null,
        React.createElement(Header, {
          summary: SUMMARY,
        }),
        React.createElement(Description, {
          summary: SUMMARY,
        })
      ),
      preloaded
        ? React.createElement(Pages, {
            pages: PAGES,
          })
        : React.createElement(
            "div",
            {
              className: ClassNames.LoadingCell,
            },
            React.createElement(LoadingIcon)
          )
    )
  );
};
