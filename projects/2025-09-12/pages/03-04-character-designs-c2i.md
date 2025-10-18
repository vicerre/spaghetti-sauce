---
class: colored-edge colored-edge-alis flex flex-col
---

# Why character designs?

### Example: "concept-to-image" benchmarks

<div class="flex-auto flex-center">
```mermaid {scale: 0.55}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart TD

    dalle2(["DALL·E 2<br/>[2022-08-28]"])
    dalle2input@{ img: "/03-04-assets/vic-pixel-art_2022-07-24.png" }
    dalle2prompt["(no prompt)"]
    dalle2output@{ img: "/03-04-assets/vic-variation-1_2022-08-28.png", h: 128, constraint: "on" }
    dalle2input --> dalle2 --> dalle2output
    dalle2prompt --> dalle2

    anythingv3(["Stable Diffusion 1.5<br/>(Anything V3)<br/>[2023-12-06]"])
    anythingv3input@{ img: "/03-04-assets/vic-key_2023-07-24.png", h: 256, constraint: on }
    anythingv3prompt["&quot;masterpiece, armin_vicerre, portrait, 3/4 view, 1boy, solo&quot;"]
    anythingv3output@{ img: "/03-04-assets/anythingv3-vic-portrait_2023-12-06.png", h: 256, constraint: "on" }
    anythingv3input --> anythingv3 --> anythingv3output
    anythingv3prompt --> anythingv3
    
    pony(["Stable Diffusion XL<br/>(Pony Diffusion V6 XL)<br/>[2024-08-08]"])
    ponyinput@{ img: "/03-04-assets/2024-03-13_image-134.png", h: 256, constraint: "on" }
    ponyprompt["&quot;score_9, score_8_up, score_7_up, source_anime, armin_vicerre, key art, science sci-fi laboratory, glowing portal gate in background, biology, detailed background, lean, thin&quot;"]
    ponyoutput@{ img: "/03-04-assets/ponyadamw8bit-vic_2024-08-08.png", h: 256, constraint: "on" }
    
    ponyinput --> pony --> ponyoutput
    ponyprompt --> pony

    nano(["Nano Banana<br/>[2025-08-29]"])
    nanoinput("???")
    nanooutput("???")

    nanoinput --> nano --> nanooutput
```
</div>

<!--
- As for why I went with character designs over something else, well, I'd say that they offer a mix between what's familiar and what's unfamiliar. My characters are humans, but they're _really_ hard to describe accurately through a text prompt alone. A model has to really understand what makes up a character's design for it to nail this use case.
- (BTW, if anyone is interested in making these the standard test subject for subject fidelity, hit me up!)
-->

<!--
In my case, I'm trying to test how well image generation models work on quote-unquote concept-to-image prompts. In this case, it's not enough to get something that resembles the original but instead understand it with a high degree of fidelity. This is something that's really hard to do with text-to-image alone.

I'm explaining this pretty vaguely currently, but I'll explain what I mean in more detail as we cover each model one-at-a-time.
-->
