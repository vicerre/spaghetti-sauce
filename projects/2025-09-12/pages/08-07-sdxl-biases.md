---
class: colored-edge colored-edge-vic flex flex-col
---

# Results

- Open-source, customizable model means biased training data

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
    sdxlinput@{ img: "/08-07-assets/alis-key_2024-08-11.png", h: 192, constraint: "on" }
    sdxlinputetc["+ 15 images and captions"]
    sdxlprompt["4 prompts"]
    sdxloutput1@{ img: "/08-07-assets/pony-alis-female-1_2024-07-22.png", h: 192, constraint: "on" }
    sdxloutput2@{ img: "/08-07-assets/pony-alis-female-2_2024-07-22.png", h: 192, constraint: "on" }
    sdxloutput3@{ img: "/08-07-assets/pony-alis-female-3_2024-07-22.png", h: 192, constraint: "on" }
    sdxloutput4@{ img: "/08-07-assets/pony-alis-female-4_2024-07-22.png", h: 192, constraint: "on" }

    subgraph inputs
        sdxlinput ~~~ sdxlinputetc
    end
    subgraph outputs
        sdxloutput1 ~~~ sdxloutput2
        sdxloutput3 ~~~ sdxloutput4
    end

    inputs --> lora --> sdxl --> outputs
    sdxlprompt --> sdxl
```
</div>


<!--
- Alis is a pretty girl. 👌
- I can't say that he is 1boy in the prompt since that makes him MANLY.
- It's not always optimal to filter out NSFW material from the model, either, since NSFW data tends to be high-quality data.
-->

<!--
I also want to take a moment to speak up about the training biases for the Stable Diffusion ecosystem. Stable Diffusion is an open source model, so there's a wide range of people who create models for the architecture.

The models that have been trained on digital art have a bias towards female characters, which is most prominently seen with Alis, who is often interpreted as a female character, even though this wasn't a problem with previous models when using prompts with similar levels of detail.

Also, outside of Alis's gender, it can be hard to get results that didn't make him a stereotypically pretty guy as well, and I couldn't prompt him as a guy without him turning into a 💪 guy.
-->
