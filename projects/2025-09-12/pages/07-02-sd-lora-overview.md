---
class: colored-edge colored-edge-solana
---

# Stable Diffusion 1.5 + LoRA

- Low-Rank Adaptation = "LoRA"
- Method of teaching image model new concepts, e.g., subjects and styles
- Vastly more efficient than training the entire model

Technical details:

- LoRA training browser UI: [Kohya](https://github.com/bmaltais/kohya_ss)
- Image generation browser UI: [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- Base model: [Counterfeit-V3.0](https://civitai.com/models/4468/counterfeit-v30) (SD 1.5 fine-tune for anime-style art)

[stable-diffusion-lora]: https://machinelearningmastery.com/using-lora-in-stable-diffusion/

<!--
The next technology that was useful was Low-Rank Adaptation, or LoRA. In short, LoRA lets you train a small part of the Stable Diffusion architecture on new concepts, which is handy if you want a model to learn how to draw something it hasn't seen before.

So how does this technology do?
-->
