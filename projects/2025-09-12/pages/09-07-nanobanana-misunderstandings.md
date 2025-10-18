---
class: colored-edge colored-edge-alis flex flex-col
---

# Results

- Inferences can be incorrect, though not ungrounded

<div class="flex-auto flex-center">
```mermaid {scale: 0.65}
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
    nanoinput1@{ img: "/09-07-assets/solana-key_2024-02-08.png", h: 128, constraint: "on" }
    nanoinput2@{ img: "/09-07-assets/solana-key_2024-08-03.png", h: 128, constraint: "on" }
    nanoinput3@{ img: "/09-07-assets/solana-chibi-accessories_2024-09-27.png", h: 128, constraint: "on" }
    nanoinputetc["+ 5 images (as collage)"]
    nanoprompt["4 prompts"]
    nanooutput1@{ img: "/09-07-assets/nanobanana-solana-pokemon_2025-08-30.png", h: 192, constraint: "on" }
    nanooutput2@{ img: "/09-07-assets/nanobanana-solana-pixel-art_2025-08-30.png", h: 192, constraint: "on" }
    nanooutput3@{ img: "/09-07-assets/nanobanana-solana-squirrel-2025-08-30.png", h: 192, constraint: "on" }
    nanooutput4@{ img: "/09-07-assets/nanobanana-solana-caricature_2025-08-30.png", h: 192, constraint: "on" }

    subgraph inputs
        nanoinput1 ~~~ nanoinput2
        nanoinput3 ~~~ nanoinputetc
    end

    subgraph outputs
        nanooutput1 ~~~ nanooutput3
        nanooutput2 ~~~ nanooutput4
    end

    inputs --> nano --> outputs
    nanoprompt --> nano
```
</div>

[zuko-scar-wrong-side]: https://otsanda.tumblr.com/post/7543332752

<!--
- The model sometimes misinterprets Vic's scarf as being both red and blue, when it's only red, and it's Vic's turtleneck that's blue.
-->

<!--
Even though the model is a lot better at inferences, it sometimes makes bad inferences or otherwise hallucinates just like previous models. For instance, it still likes to draw Solana's tail with a white tip like a red fox's tail, and when it's not drawing her as a red fox, it draws her as a squirrel.

Also, want to point out a small discrepancy here. Solana's hair is asymmetrical here, where it kind of comes out like a plume from house left. Nano Banana often gets asymmetrical features flipped. If you look at the pixel art image and the image in my last slide, you can see where it flips her hair. I think that's interesting and says something about the training data used to create the model for Nano Banana.
-->
