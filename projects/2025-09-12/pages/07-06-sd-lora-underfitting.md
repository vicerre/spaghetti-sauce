---
class: colored-edge colored-edge-solana flex flex-col
---

# Results

- Underfitting

<div class="flex-auto flex-center">
```mermaid {scale: 0.6}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#FDCFCF"
        secondaryColor: "#FEE7E7"
        tertiaryColor: "#FEE7E7"
---

    flowchart LR

    sd(["Stable Diffusion 1.5"])
    lora(["LoRA"])
    sdinput1@{ img: "/07-06-assets/solana-key_2022-11-01.png", h: 192, constraint: "on" }
    sdinput2@{ img: "/07-06-assets/solana-key_2023-08-04.png", h: 192, constraint: "on" }
    sdinput3@{ img: "/07-06-assets/solana-pixel-art_2023-07-02.png", h: 128, constraint: "on" }
    sdinputetc["+3 images and captions"]
    sdprompt["&quot;masterpiece, solora, 1girl, solo&quot;"]
    sdoutput1@{ img: "/07-06-assets/anythingv3-solana-mechanic_2023-12-15.png", h: 192, constraint: "on" }
    sdoutput2@{ img: "/07-06-assets/counterfeit-solana-bust_2023-12-15.png", h: 192, constraint: "on" }
    sdoutput3@{ img: "/07-06-assets/counterfeit-solana_2023-12-15.png", h: 192, constraint: "on" }
    sdoutput4@{ img: "/07-06-assets/counterfeit-solana_2023-12-30.png", h: 192, constraint: "on" }

    subgraph inputs
        sdinput1 ~~~ sdinput3
        sdinput2 ~~~ sdinputetc
    end

    subgraph outputs
        sdoutput1 ~~~ sdoutput2
        sdoutput3 ~~~ sdoutput4
    end

    inputs --> lora --> sd --> outputs
    sdprompt ---> sd
```
</div>

<!--
It wasn't as though my training data was different--both Vic and Solana use the same set of clothes in their designs, and yet Solana's clothes are different. I chalk this up to a bias in the training data.
-->

<!--
Sometimes it doesn't learn what I hope for it to learn. For instance, with Solana, I gave the model a bunch of images with Solana in the same outfit, but it didn't end up associating her outfit with her design and instead drew her in a variety of different outfits.
-->
