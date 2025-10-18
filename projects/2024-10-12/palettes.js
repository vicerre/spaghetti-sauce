const FIBONACCI = {
  accent: 1,
  tertiary: 2,
  secondary: 3,
  primary: 5,
  zeroth: 8,
};

const SWATCHES = {
  "red-blouse": "#800000",
  "red-trim": "#C04040",
  red: "#F30C0C",
  "red-orange": "#FF4000",
  orange: "#FF8000",
  yellow: "#FFFF7F",
  "olive-coat": "#857848",
  "olive-hair": "#887A42",
  "brown-hair": "#64321E",
  "brown-jacket": "#603920",
  "brown-shorts": "#4B3C3C",
  "gray-trim": "#808080",
  "gray-slacks": "#47596B",
  "gray-shoes": "#304050",
  tan: "#FFDAC2",
  skin: "#FBE7E2",
  white: "#FFFFFF",
  "white-coat": "#EEF4F4",
  "teal-trim": "#AFFFFF",
  teal: "#00FFFF",
  "pine-green": "#1E7A7A",
  "royal-blue": "#4400CC",
};

const INK_SWATCHES = {
  shadow: "#202020",
  midtone: "#404040",
  highlight: "#606060",
  white: "#FFFFFF",
  skin: "#F5EBE8",
};

const FLUORESCENT_SWATCHES = {
  orange: "#FF7945",
  yellow: "#FFEE78",
  "light-blue": "#92D2FF", // bowtie
  "mid-blue": "#3180D9", // nose
  "dark-blue": "#4674A7", // feet
  white: "#FFFFFF",
  gray: "#626C77",
};

const STELLAR_SWATCHES = {
  red: "#e11258",
  yellow: "#ffe87d",
  peach: "#fffdfb",
  cyan: "#afeeff",
  turquoise: "#34d8d0",
  "dark-blue": "#30497e",
};

export const PALETTES = {
  alis: [
    {
      hex: SWATCHES["olive-hair"],
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES["olive-coat"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES.orange,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES.skin,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES["white-coat"],
      weight: FIBONACCI.zeroth,
    },
    {
      hex: SWATCHES.teal,
      weight: FIBONACCI.accent,
    },
    {
      hex: SWATCHES["pine-green"],
      weight: FIBONACCI.secondary,
    },
  ],
  astrolotl: [
    {
      hex: STELLAR_SWATCHES.red,
      weight: FIBONACCI.primary,
    },
    {
      hex: STELLAR_SWATCHES.yellow,
      weight: FIBONACCI.secondary,
    },
    {
      hex: STELLAR_SWATCHES.peach,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: STELLAR_SWATCHES.cyan,
      weight: FIBONACCI.secondary,
    },
    {
      hex: STELLAR_SWATCHES.turquoise,
      weight: FIBONACCI.accent,
    },
    {
      hex: STELLAR_SWATCHES["dark-blue"],
      weight: FIBONACCI.secondary,
    },
  ],
  cap35: [
    {
      hex: FLUORESCENT_SWATCHES.orange,
      weight: FIBONACCI.accent,
    },
    {
      hex: FLUORESCENT_SWATCHES.yellow,
      weight: FIBONACCI.secondary,
    },
    {
      hex: FLUORESCENT_SWATCHES["light-blue"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: FLUORESCENT_SWATCHES["mid-blue"],
      weight: FIBONACCI.accent,
    },
    {
      hex: FLUORESCENT_SWATCHES["dark-blue"],
      weight: FIBONACCI.tertiary,
    },
    {
      hex: FLUORESCENT_SWATCHES.gray,
      weight: FIBONACCI.secondary,
    },
    {
      hex: FLUORESCENT_SWATCHES.white,
      weight: FIBONACCI.zeroth,
    },
  ],
  solana: [
    {
      hex: SWATCHES["red-blouse"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES["red-trim"],
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES["red-orange"],
      weight: FIBONACCI.primary,
    },
    {
      hex: SWATCHES.yellow,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES.skin,
      weight: FIBONACCI.primary,
    },
    {
      hex: SWATCHES["teal-trim"],
      weight: FIBONACCI.accent,
    },
    {
      hex: SWATCHES.teal,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES["brown-shorts"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES["gray-trim"],
      weight: FIBONACCI.accent,
    },
    {
      hex: SWATCHES.white,
      weight: FIBONACCI.tertiary,
    },
  ],
  storyteller: [
    {
      hex: INK_SWATCHES.skin,
      weight: FIBONACCI.secondary,
    },
    {
      hex: INK_SWATCHES.white,
      weight: FIBONACCI.secondary,
    },
    {
      hex: INK_SWATCHES.highlight,
      weight: FIBONACCI.secondary,
    },
    {
      hex: INK_SWATCHES.midtone,
      weight: FIBONACCI.primary,
    },
    {
      hex: INK_SWATCHES.shadow,
      weight: FIBONACCI.zeroth,
    },
  ],
  vic: [
    {
      hex: SWATCHES["brown-jacket"],
      weight: FIBONACCI.primary,
    },
    {
      hex: SWATCHES["brown-hair"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES.red,
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES.orange,
      weight: FIBONACCI.accent,
    },
    {
      hex: SWATCHES.tan,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES.skin,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES.white,
      weight: FIBONACCI.tertiary,
    },
    {
      hex: SWATCHES.teal,
      weight: FIBONACCI.accent,
    },
    {
      hex: SWATCHES["royal-blue"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES["gray-slacks"],
      weight: FIBONACCI.secondary,
    },
    {
      hex: SWATCHES["gray-shoes"],
      weight: FIBONACCI.tertiary,
    },
  ],
};
