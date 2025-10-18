---
class: colored-edge colored-edge-alis flex flex-col
# layout: two-cols
---

# Results

- Excellent at image modifications + composition without copy-pasting or overfitting

<div class="flex-auto flex-center">
```mermaid {scale: 0.5}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart LR
    
    nano(["Nano Banana"])
    nanoinput1@{ img: "/09-06-assets/alis-key_2024-08-11.png", h: 192, constraint: "on" }
    nanoinput2@{ img: "/09-06-assets/solana-key_2024-02-08.png", h: 192, constraint: "on" }
    nanoinput3@{ img: "/09-06-assets/vic-key_2024-08-11.png", h: 192, constraint: "on" }
    nanoprompt["&quot;Generate a image of the three characters taking a selfie. The female, red-haired character is in the middle, holding the camera. The character with olive-brown hair is to house left and the character with brown-and-white hair is to house right. Behind them is a Florentine-looking piazza at evening with cozy-looking lights. Each character is depicted from the torso up. The image is in the style of a JRPG splash art illustration.&quot;"]
    nanooutput@{ img: "/09-06-assets/nanobanana-alis-solana-vic_2025-08-30.png", h: 384, constraint: "on" }

    subgraph inputs
        direction TB

        nanoinput1 ~~~ nanoinput2
        nanoinput3 ~~~ nanoinput2
    end

    inputs --> nano --> nanooutput
    nanoprompt ---> nano
```

</div>

[nano-banana-13-images]: https://twitter.com/MrDavids1/status/1960783672665128970

<!--
- Note that the models don't get the prompt 100% correct--if you look closely, you can see that I asked for Solana to be in the center, but in the output image, she's on the left.
-->

<!--
Nano Banana is also a major step up from Stable Diffusion in handling complex scenes. It can draw all of my characters in the same scene, with a custom background, with additions not specified via image, and it nails it. And according to what I've seen on social media, this doesn't even require effort on Nano Banana's part.

Not only is it good at handling complexity, it's good at fidelity too. Compared to the other image generation models, it took my images and reinterpreted them in a way that was both faithful to the original art and yet wasn't a direct copy-paste.

If anything, it's _too_ accurate. Like I've only noticed how weirdly skinny Vic's legs were in the drawing I've been using, and it's only now that I realize how pale-looking Alis is. It makes me self-conscious about my art and indirectly makes me want to make my own art better.
-->
