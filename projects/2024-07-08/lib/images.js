import { DebugSettings } from "./debugSettings.js";

export const preloadImage = async (src) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    // Enables CORS on request.
    // Allows CDN-hosted app to read image data.
    // https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_enabled_image
    // https://stackoverflow.com/questions/17035106
    img.crossOrigin = "anonymous";
    img.onload = () => resolve(img);
    img.onerror = reject;
    img.src = src;
  });
};

export const loadObfuscated = async (img) => {
  if (!DebugSettings.obfuscateImages) {
    return img.src;
  }

  const { height, width } = img;

  const canvasin = new OffscreenCanvas(width, height);
  const contextin = canvasin.getContext("2d");

  const canvasout = new OffscreenCanvas(height, width);
  const contextout = canvasout.getContext("2d");

  if (contextin && contextout) {
    contextin.drawImage(img, 0, 0);
    const imageData = contextin.getImageData(0, 0, width, height);
    const transposed = new ImageData(imageData.data, height, width);
    contextout.putImageData(transposed, 0, 0);
  }
  const blob = await canvasout.convertToBlob();
  return URL.createObjectURL(blob);
};
