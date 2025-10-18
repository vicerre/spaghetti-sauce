---
class: colored-edge colored-edge-solana flex flex-col
---

# Results

- Actually a game-changer
- Good at inferences

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
    sdinput1@{ img: "/07-03-assets/vic-full-body_2023-07-05.png", h: 256, constraint: "on" }
    sdinput2@{ img: "/07-03-assets/vic-bust_2023-07-28.png", h: 256, constraint: "on" }
    sdinput3@{ img: "/07-03-assets/anythingv3-vic_2022-12-30.png", h: 128, constraint: "on" }
    sdinputetc["+10 images and captions"]
    sdprompt["&quot;masterpiece, armin_vicerre, (💥: 1.2), (full body: 1.0), 1boy, solo&quot;"]
    sdoutput@{ img: "/07-03-assets/counterfeit-vic-boom_2024-01-08.png", h: 256, constraint: "on" }

    subgraph inputs
        sdinput1 ~~~ sdinput3
        sdinput2 ~~~ sdinputetc
    end

    inputs --> lora --> sd --> sdoutput
    sdprompt --> sd
```
</div>

<!--
- When you train a LoRA, you usually see sample images during the training process, and it's exciting seeing those training images converge onto the concept you trained it on.
-->

<!--
This is amazing, actually. It's actually magical to see a model actually the aspects of your character with a single keyword instead of having to describe them in full. You can see in this diagram that I needed much fewer tokens to draw Vic compared to the previous model.

If you look at this generation, you can see some really interesting details. Like you can see that in the output image, it drew Vic in a different pose than any of the input images, and to do that, it needs to understand how a human body articulates so it looks natural natural. Also, it needs to know how hair should move if a person is moving and how a scarf should move, too.

Also, it got the nose right!
-->
