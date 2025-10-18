---
class: colored-edge colored-edge-vic flex flex-col
---

# Results

- Overfitting is still an issue

<div class="flex-auto flex-center">
```mermaid {scale: 0.7}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart TD

    sdxl1(["Stable Diffusion XL"])
    sdxl2(["Stable Diffusion XL"])
    sdxl3(["Stable Diffusion XL"])
    sdxlinput1@{ img: "/08-06-assets/vic-swooshy_2023-05-13.png", h: 128, constraint: "on" }
    sdxlinput2@{ img: "/08-06-assets/vic-bust_2024-03-13.png", h: 192, constraint: "on" }
    sdxlinput3@{ img: "/08-06-assets/alis-solana-vic-manga_2024-07-12.png", h: 192, constraint: "on" }
    sdxloutput1@{ img: "/08-06-assets/counterfeitxl-vic-bust_2023-12-08.png", h: 256, constraint: "on" }
    sdxloutput2@{ img: "/08-06-assets/pony-vic-hunched_2024-02-21.png", h: 256, constraint: "on" }
    sdxloutput3@{ img: "/08-06-assets/pony-vic-bad_2024-08-07.png", h: 256, constraint: "on" }

    sdxlinput1 --> sdxl1 --> sdxloutput1
    sdxlinput2 --> sdxl2 --> sdxloutput2
    sdxlinput3 --> sdxl3 --> sdxloutput3
```
</div>

<!--
The model still has some problems with overfitting in places too.

For instance, on my first attempt at training a LoRA for Vic, I got a lot of Vics with a lot of swooshy white bit saround him, even when I didn't ask for it. It turns out that this one image I had of him with white swooshes caused the model to think that white swooshes were a part of his design.

In the middle example, I had a drawing of Vic that was a bust shot, and looking at the generations, I started getting stumpy-looking Vics. The model was conflating the bust shot with how Vic should be drawn from the legs down, which means that that particular Vic looks very stumpy.

In the right example, I fed the model an image with both Vic and Solana in it, and it took Solana's face and gave it to Vic. You can see that in the image generated, Vic's the one with closed eyes and a blush, even though none of his drawings depicted him that way.
-->
