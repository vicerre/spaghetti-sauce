import argparse
import math
from typing import Tuple

import numpy as np
from PIL import Image

# [Original writeup]
#
# Image obfuscation algorithm
#
# The image displayed in this post is obfuscated.
# The following instructions were used to obfuscate the image.
# To deobfuscate the image, reverse the instructions.
#
# 1. Convert the image from a lossless file format (e.g. PNG) to a bitmap file format (i.e. BMP).
# 2. Using a hex editor, change the bytes representing the image dimensions from 768 × 768 to 576 × 1024. In bytes (big-endian):
#    - Width: `0x00000300` → `0x00000240`
#    - Height: `0x00000300` → `0x00000400`
# 3. Using an image editor, rotate the image 90 degrees clockwise.
# 4. Using a hex editor, change the bytes representing the image dimensions from 1024 × 576 to 768 × 768. In bytes (big-endian):
#    - Width: `0x00000240` → `0x00000300`
#    - Height: `0x00000400` → `0x00000300`
# 5. Using an image editor, rotate the image 90 degrees counterclockwise.
# 6. Convert the image from a bitmap file format (i.e. BMP) to a lossless image file format (e.g. PNG).


def obfuscate(im: Image, resize: Tuple[int, int], reverse: bool = False):
    imsize = im.size
    numchannels = len(im.getbands())

    if imsize[0] * imsize[1] != resize[0] * resize[1]:
        raise Exception(f"Cannot reshape {imsize} -> {resize}.")

    imdata = np.asarray(im)

    processed = imdata

    if reverse:
        processed = np.rot90(processed, k=-1)
        processed = processed.reshape((*reversed(resize), numchannels))
        processed = np.rot90(processed, k=1)
        processed = processed.reshape((*imsize, numchannels))
    else:
        processed = processed.reshape((*resize, numchannels))
        processed = np.rot90(processed, k=-1)
        processed = processed.reshape((*imsize, numchannels))
        processed = np.rot90(processed, k=1)

    canvas = Image.fromarray(processed)
    return canvas


def main(path: str):
    # imsize = (768, 768)
    reshape_size = (576, 1024)

    im = Image.open(path)
    out = obfuscate(im, reshape_size, reverse=False)
    out.show()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", help="Path to image file")

    args = parser.parse_args()
    main(args.i)
