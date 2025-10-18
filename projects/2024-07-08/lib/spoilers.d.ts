import { CorrectType } from "./correctType.js";
import { PuzzleType } from "./puzzleType.js";

interface Flag<T> {
  defaultValue: T;
  key: string;
}

export interface Page {
  data: {
    correct:
      | {
          type: typeof CorrectType.Boom;
        }
      | {
          type: typeof CorrectType.EmojiSpam;
        }
      | {
          imgsrc: string;
          type: typeof CorrectType.Image;
        };
    imgsrc: string;
  };
  puzzle:
    | {
        expected: number[];
        hints: string[];
        initialValue: number[];
        prompt: string;
        suffix: string;
        type: typeof PuzzleType.MultiDigit;
      }
    | {
        expected: string[];
        hints: string[];
        initialValue: string;
        prefix?: string;
        prompt: string;
        suffix?: string;
        type: typeof PuzzleType.Text;
      };
  schema: {
    hintsUsed: Flag<number>;
    input: Flag<unknown>; // TS: use more robust typing
    solved: Flag<boolean>;
  };
}

export const PAGES: Page[];
export const SUMMARY: {};
