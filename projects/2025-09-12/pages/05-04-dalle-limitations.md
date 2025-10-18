---
class: colored-edge colored-edge-vic flex flex-col
---

# Results

- Doesn't copy subject directly

<div class="flex-auto flex-center">
```mermaid {scale: 1.0}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart LR

    dalle(["DALL·E 2"])
    dalleinput@{ img: "/05-04-assets/vic-pixel-art_2022-07-24.png", h: 128, constraint: "on" }
    dalleoutput1@{ img: "/05-04-assets/dalle2-vic-variation-1_2022-08-28.png", h: 128, constraint: "on" }
    dalleoutput2@{ img: "/05-04-assets/dalle2-vic-variation-2_2022-08-28.png", h: 128, constraint: "on" }
    dalleoutput3@{ img: "/05-04-assets/dalle2-vic-variation-3_2022-08-28.png", h: 128, constraint: "on" }

    subgraph outputs
        dalleoutput1 ~~~ dalleoutput2
        dalleoutput1 ~~~ dalleoutput3
    end
    
    dalleinput --> dalle --> outputs
```
</div>

[dalle-architecture]: https://www.geeksforgeeks.org/deep-learning/dalle-2-architecture/

<!--
The faults of DALL-E are pretty straightforward. "Dall-E image variations don't actually learn the full gestalt behind the image. It takes elements it knows about and reassembles it into image variations.

It's more obvious when you take a look at something like this drawing. It's trying to be a pixelated version of Vic, but his hair doesn't have the same shape, and it shrinks his nose.
-->
