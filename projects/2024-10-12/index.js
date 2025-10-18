import * as d3 from "d3";
import { PALETTES } from "./palettes.js";

// https://d3js.org/d3-shape/pie

const UNIT = 128;
const DIMENSIONS = {
  border: 4,
  height: UNIT * 3,
  radius: UNIT,
  width: UNIT * 3,
};

const arc = d3.arc().innerRadius(0).outerRadius(DIMENSIONS.radius);

const pie = d3
  .pie()
  .sort(null) // disable default sort
  .value((d) => d.weight);

const makePalette = (palette) => {
  const svg = d3
    .select("#root")
    .append("svg")
    .attr("width", DIMENSIONS.width)
    .attr("height", DIMENSIONS.height);

  // Border
  svg
    .append("circle")
    .attr("cx", DIMENSIONS.width / 2)
    .attr("cy", DIMENSIONS.height / 2)
    .attr("fill", "#171535")
    .attr("r", DIMENSIONS.radius + DIMENSIONS.border);

  // Pie
  const g = svg
    .append("g")
    .attr(
      "transform",
      `translate(${DIMENSIONS.width / 2}, ${DIMENSIONS.height / 2})`
    );

  g.selectAll("path")
    .data(pie(palette))
    .enter()
    .append("path")
    .attr("d", (d) => arc(d))
    .attr("fill", (d) => d.data.hex)
    .attr("stroke", (d) => d.data.hex)
    .attr("stroke-width", "1px");
};

Object.values(PALETTES).forEach((palette) => makePalette(palette));
