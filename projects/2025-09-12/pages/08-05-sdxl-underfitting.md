---
class: colored-edge colored-edge-vic flex flex-col
---

# Results

- Underfitting is much less problematic

<div class="flex-auto flex-center">
```mermaid {scale: 0.65}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart LR

    sdxl(["Stable Diffusion XL"])
    lora(["LoRA"])
    sdxlinput1@{ img: "/08-05-assets/solana-key_2024-02-08.png", h: 128, constraint: "on" }
    sdxlinput2@{ img: "/08-05-assets/solana-key_2024-08-03.png", h: 128, constraint: "on" }
    sdxlinputetc["+ 14 images and captions"]
    sdxlprompt["4 prompts"]
    sdxloutput1@{ img: "/08-05-assets/pony-solana-1_2024-08-05.png", h: 192, constraint: "on" }
    sdxloutput2@{ img: "/08-05-assets/pony-solana-2_2024-08-05.png", h: 192, constraint: "on" }
    sdxloutput3@{ img: "/08-05-assets/pony-solana-3_2024-08-05.png", h: 192, constraint: "on" }
    sdxloutput4@{ img: "/08-05-assets/pony-solana-5_2024-08-05.png", h: 192, constraint: "on" }

    subgraph inputs
        sdxlinput1 ~~~ sdxlinputetc
        sdxlinput2 ~~~ sdxlinputetc
    end

    subgraph outputs
        sdxloutput1 ~~~ sdxloutput2
        sdxloutput3 ~~~ sdxloutput4
    end

    inputs --> lora --> sdxl ---> outputs
    sdxlprompt ---> sdxl
```
</div>

<!--
- Hair symmetry is preserved!
-->

<!--
Underfitting is less problematic. It's able to get Solana's outfit right in addition to her hair. It doesn't get it 100%, like it doesn't understand how her armbands work or that her tail doesn't have a white tip, but it's much better than Stable Diffusion 1.5.
-->
