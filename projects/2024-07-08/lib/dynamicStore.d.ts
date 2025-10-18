import { Flag } from "./spoilers.js";

interface Store {
  clear: () => void;
  keys: {
    [key: string]: unknown;
  };
  updateKey: (key: string, value: unknown) => void;
}

// TS: use more robust typings
export function createDynamicSlice<T>(...args): Store;
export function selectAggregate<T, U>(
  schemata: Flag<T>[],
  aggregator: (values: T[]) => U
): (state: unknown) => U;
export function useKeyState<T>(
  useStore: Function
): (schema: Flag<T>) => [T, (value: T) => void];
