import { create } from "zustand";
import { createDynamicSlice } from "./dynamicStore.js";
import { persist } from "zustand/middleware";

const STORE_NAME = "save-data";

export const useSaveStore = create(
  persist(
    (...args) => ({
      ...createDynamicSlice(...args),
    }),
    {
      name: STORE_NAME,
    }
  )
);
