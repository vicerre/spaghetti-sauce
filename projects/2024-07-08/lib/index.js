import React from "react";
import ReactDOM from "react-dom";
import { App } from "../components/App.js";

const main = () => {
  const rootEl = document.getElementById("root");
  const root = ReactDOM.createRoot(rootEl);
  root.render(React.createElement(App));
};

main();
