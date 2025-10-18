import React from "react";

/**
 * @typedef {import('./dynamicStore').selectAggregate} selectAggregate
 * @typedef {import('./dynamicStore').useKeyState} useKeyState
 * @typedef {import('./dynamicStore').createDynamicSlice} createDynamicSlice
 */

/** @type {createDynamicSlice} */
export const createDynamicSlice = (set) => ({
  clear: () => set(() => ({ keys: {} })),
  keys: {},
  updateKey: (key, value) =>
    set((state) => ({
      keys: {
        ...state.keys,
        [key]: value,
      },
    })),
});

const selectValue = (schema) => (state) =>
  state.keys[schema.key] ?? schema.defaultValue;

/** @type {selectAggregate} */
export const selectAggregate = (schemata, aggregator) => (state) => {
  const values = schemata.map((schema) => selectValue(schema)(state));
  return aggregator(values);
};

/** @type {useKeyState} */
export const useKeyState = (useStore) => (schema) => {
  const { key } = schema;
  const value = useStore((state) => selectValue(schema)(state));
  const updateValue = useStore((state) => state.updateKey);

  const setValue = React.useCallback(
    (v) => {
      updateValue(key, v);
    },
    [key, updateValue]
  );

  return [value, setValue];
};
