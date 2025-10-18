---
class: colored-edge colored-edge-solana flex flex-col
---

# Results

- Frees up tokens to be used on other image aspects

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
    sdinput@{ img: "/07-04-assets/vic-full-body_2023-07-05.png", h: 256, constraint: "on" }
    sdinputetc["+12 images and captions"]
    sdprompt["4 prompts"]
    sdoutput1@{ img: "/07-04-assets/anythingv3-vic-chibi_2023-12-14.png", h: 192, constraint: "on" }
    sdoutput2@{ img: "/07-04-assets/ayonimix-vic-realism_2024-01-11.png", h: 128, constraint: "on" }
    sdoutput3@{ img: "/07-04-assets/aziibpixelmix-vic-sprite_2024-01-08.png", h: 192, constraint: "on" }
    sdoutput4@{ img: "/07-04-assets/counterfeit-vic-figurine_2023-12-15.png", h: 192, constraint: "on" }

    subgraph inputs
        sdinput ~~~ sdinputetc
    end

    subgraph outputs
        sdoutput1 ~~~ sdoutput2
        sdoutput3 ~~~ sdoutput4
    end

    inputs --> lora --> sd --> outputs
    sdprompt --> sd
```
</div>

<!--
- You know the Nano Banana trend to make 1/7 figurines? Well, Stable Diffusion could do that almost two years ago.
-->

<!--
And what was even crazier was that it knew the principles that made up a character between styles. Like here, I have Vic drawn in the style of super-deformed characters, photorealism, pixel art, and as a figurine, and it knows to keep the parts that are unique to him like the way his hair flares out and his red scarf.

Even with the advances in image technology now, it still blows my mind that a computer from just a few years ago just knows what elements make Vic look like a Vic.
-->
