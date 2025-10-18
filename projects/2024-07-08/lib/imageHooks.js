import React from "react";

import { loadObfuscated, preloadImage } from "./images.js";
import { useKeyState } from "./dynamicStore.js";
import { useImageStore } from "./imageStore.js";

export const usePreloadedImages = (pages) => {
  const [loaded, setLoaded] = React.useState(false);

  const imgsrcs = pages.flatMap((p) => {
    const srcs = [p.data.imgsrc];
    if (p.data.correct.imgsrc) {
      srcs.push(p.data.correct.imgsrc);
    }
    return srcs;
  });

  const setUrls = Object.fromEntries(
    imgsrcs.map((src) => {
      const [, setUrl] = useKeyState(useImageStore)({
        defaultValue: "",
        key: src,
      });

      return [src, setUrl];
    })
  );

  React.useEffect(() => {
    (async () => {
      await Promise.all(
        imgsrcs.map(async (src) => {
          const img = await preloadImage(src);
          const blobUrl = await loadObfuscated(img);
          setUrls[src](blobUrl);
        })
      );

      setLoaded(true);
    })();
  }, pages);

  return loaded;
};
