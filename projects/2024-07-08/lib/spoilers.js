import { PuzzleType } from "./puzzleType.js";
import { CorrectType } from "./correctType.js";

/**
 * @typedef {import('./spoilers').Page} Page
 */

/**
 * @type {Page[]}
 */
export const PAGES = [
  {
    data: {
      correct: {
        type: CorrectType.Boom,
      },
      imgsrc: "./images/obfuscated1.png",
    },
    puzzle: {
      initialValue: [0, 0, 0],
      expected: [5, 1, 1],
      hints: [
        "Where could you extract three numbers from this page?",
        "The title of the comic seems suspicious.",
        'Why is the comic formatted as "VICminusRomance" and not "Vic minus romance"?',
        "How can you convert <strong>V I C</strong> into three numbers?",
        "V I C in Roman numerals is 5 1 100, so the digits you need are <strong>5 1 1</strong>.",
      ],
      prompt: "Which numbers open the combination lock?",
      suffix: " 0 0",
      type: PuzzleType.MultiDigit,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page1hint",
      },
      input: {
        defaultValue: [0, 0, 0],
        key: "page1input",
      },
      solved: {
        defaultValue: false,
        key: "page1solved",
      },
    },
  },
  {
    data: {
      correct: {
        type: CorrectType.Boom,
      },
      imgsrc: "./images/obfuscated2.png",
    },
    puzzle: {
      expected: ["romaine", "romaine lettuce"],
      hints: [
        "Look at the shape of the lettuce. What real-world variety does it resemble?",
        "Could this puzzle use logic similar to the previous puzzle?",
        'In the previous puzzle, "Romance" referred to Roman numerals. What variety of lettuce could you associate with Rome?',
        'This variety of lettuce is called "romaine lettuce", so the solution is <strong>romaine</strong>.',
      ],
      initialValue: "",
      prompt: "What's in the box?",
      suffix: " lettuce",
      type: PuzzleType.Text,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page2hint",
      },
      input: {
        defaultValue: "",
        key: "page2input",
      },
      solved: {
        defaultValue: false,
        key: "page2solved",
      },
    },
  },
  {
    data: {
      correct: {
        imgsrc: "./images/obfuscated4.png",
        type: CorrectType.Image,
      },
      imgsrc: "./images/obfuscated3.png",
    },
    puzzle: {
      expected: ["iceberg", "iceberg lettuce"],
      hints: [
        "Could this puzzle use logic similar to the previous puzzle?",
        "Which variety of lettuce is named after something icy?",
        'A variety of lettuce named after something icy is "iceberg lettuce", so the solution is <strong>iceberg</strong>.',
      ],
      initialValue: "",
      prompt: "What is the <em>right</em> type of lettuce?",
      suffix: " lettuce",
      type: PuzzleType.Text,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page3hint",
      },
      input: {
        defaultValue: "",
        key: "page3input",
      },
      solved: {
        defaultValue: false,
        key: "page3solved",
      },
    },
  },
  {
    data: {
      correct: {
        type: CorrectType.Boom,
      },
      imgsrc: "./images/obfuscated5.png",
    },
    puzzle: {
      expected: ["let us leave"],
      hints: [
        'The solution is a play on the words "Lettuce leaf?"',
        'Which other element on this page pairs with the words "Lettuce leaf?"',
        'The words "Let us leave?" on the doorway sound like "lettuce leaf", so the solution is <strong>let us leave</strong>.',
      ],
      initialValue: "",
      prompt: "Lettuce leaf?",
      type: PuzzleType.Text,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page5hint",
      },
      input: {
        defaultValue: "",
        key: "page5input",
      },
      solved: {
        defaultValue: false,
        key: "page5solved",
      },
    },
  },
  {
    data: {
      correct: {
        type: CorrectType.Boom,
      },
      imgsrc: "./images/obfuscated6.png",
    },
    puzzle: {
      expected: ["armin vicerre", "vic", "vicerre"],
      hints: [
        "There are three characters named in this comic, so one of them must be it.",
        "Out of the three named characters, Solana and Alis are known. Who is the third?",
        "Vic has been named but not seen, so the solution is <strong>Vic</strong>.",
      ],
      initialValue: "",
      prompt: "Who did Solana encounter in the snow?",
      type: PuzzleType.Text,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page6hint",
      },
      input: {
        defaultValue: "",
        key: "page6input",
      },
      solved: {
        defaultValue: false,
        key: "page6solved",
      },
    },
  },
  {
    data: {
      correct: {
        type: CorrectType.EmojiSpam,
      },
      imgsrc: "./images/obfuscated7.png",
    },
    puzzle: {
      expected: ["vicplusromance", "vic plus romance"],
      hints: [
        "Why would the best title for this page be in hook brackets?",
        "Could the title be related to the other title in hook brackets?",
        'Does the expression "Vic minus romance" match the visual on the page? If not, how would you change it?',
        "If the title of the first page is 『VICminusRomance』, then the title for this page is <strong>『VicPlusRomance』</strong>.",
      ],
      initialValue: "",
      prefix: "『",
      prompt: "Final puzzle: What is the best title for this page?",
      suffix: "』",
      type: PuzzleType.Text,
    },
    schema: {
      hintsUsed: {
        defaultValue: 0,
        key: "page7hint",
      },
      input: {
        defaultValue: "",
        key: "page7input",
      },
      solved: {
        defaultValue: false,
        key: "page7solved",
      },
    },
  },
];

export const SUMMARY = {
  intro: [
    "Welcome to the 『VICminusRomance』 manga puzzle.",
    "In this puzzle, you will use your puzzle-solving skills to discover the manga's story. Each page must be unlocked by reading and solving the previous page's puzzle.",
    "About the puzzles in this manga:",
    "- Each solution will be a number or a short English word/phrase.",
    "- Real-world knowledge may be required.",
    "- You do not need prior knowledge of these characters.",
    "- Hints will be available.",
    "Good luck and happy solving!",
  ],
  metadata: {
    endDate: "2024-07-11",
    startDate: "2024-07-08",
  },
  reverseFlow: true,
  title: "『VICminusRomance』",
};
