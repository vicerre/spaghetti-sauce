---
class: colored-edge colored-edge-solana flex flex-col
---

# Results

- Overfitting on low-shot training data

<div class="flex-auto flex-center">
```mermaid {scale: 0.7}
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
    sdinput1@{ img: "/07-07-assets/alis-headshot_2023-08-29.jpg", h: 128, constraint: "on" }
    sdinput2@{ img: "/07-07-assets/alis-bust_2023-12-26.png", h: 128, constraint: "on" }
    sdinput3@{ img: "/07-07-assets/alis-key_2023-06-09.png", h: 128, constraint: "on" }
    sdinputetc["+ 1 image and caption"]
    sdprompt["&quot;masterpiece, alistair_vicerre, (character sheet: 1.2), 1boy, solo&quot;"]
    sdoutput@{ img: "/07-07-assets/counterfeit-alis_2023-12-27.png", h: 384, constraint: "on" }

    subgraph inputs
        sdinput2 ~~~ sdinput3
        sdinput1 ~~~ sdinputetc
    end

    inputs --> lora --> sd --> sdoutput
    sdprompt ---> sd
```

</div>

<!--
It doesn't do too well on low volumes of training data, too. I can't really show you this effect except in aggregate, but here's one of the more egregious examples I got, where it redrew Alis from the same angle seven times in one image. This isn't something I can fix by changing the training rate, either, or else it would end up underfitting.
-->
