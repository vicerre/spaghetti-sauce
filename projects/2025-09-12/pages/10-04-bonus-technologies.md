---
class: colored-edge colored-edge-solana flex flex-col
---

# Bonus image generation technologies

- [2023-12-16] [ControlNet](https://github.com/lllyasviel/ControlNet): guide output with doodles, depth maps, or poses
- [2024-01-06] [IP-Adapter](https://github.com/tencent-ailab/IP-Adapter): one-shot image-to-image

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
    sdinput@{ img: "/10-03-assets/vic-key_2023-07-05.png", h: 256, constraint: "on" }
    sdipadapter(["IP-Adapter"])
    sdlora(["no LoRA"])
    sdprompt["&quot;masterpiece, armin_vicerre roasting marshmallows over a campfire, 1boy, solo&quot;"]
    sdoutput1@{ img: "/10-03-assets/counterfeit-ipadapter-vic-1_2024-01-06.png", h: 192, constraint: "on" }
    sdoutput2@{ img: "/10-03-assets/counterfeit-ipadapter-vic-2_2024-01-06.png", h: 192, constraint: "on" }
    sdoutput3@{ img: "/10-03-assets/counterfeit-ipadapter-vic-3_2024-01-06.png", h: 192, constraint: "on" }

    subgraph outputs
        sdoutput1 ~~~ sdoutput2
        sdoutput1 ~~~ sdoutput3
    end

    sdinput --> sdipadapter --> sd --> outputs
    sdlora ~~~ sd
    sdprompt --> sd
```
</div>

[controlnet-discord-comment]: https://discord.com/channels/448538687983321098/1041838659277688903/1075769875315838997
[controlnet-qr-code]: https://redd.it/141hg9x/

<!--
- ControlNet: Doesn't work with Pony Diffusion XL without a custom workflow.
- IP-Adapter: Not bad for low-shot image generation, just not as good as LoRA if you have the right raining data (e.g. Vic looks too boyish).
-->

<!--
And here are some of the other technologies used with Stable Diffusion I tried for similar reasons. ControlNet lets you guide the output image using various guidelines, and IP-Adapter lets you generate images using a single reference. IP-Adapter draws Vic pretty accurately, but LoRAs are better when you have a lot more reference images so you can tell the model, "Hey, Vic is actually, like, 30 years old, can you make him look older?"
-->
