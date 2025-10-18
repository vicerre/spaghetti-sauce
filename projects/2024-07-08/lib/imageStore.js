import { create } from "zustand";
import { createDynamicSlice } from "./dynamicStore.js";

export const useImageStore = create((...args) => ({
  ...createDynamicSlice(...args),
}));
