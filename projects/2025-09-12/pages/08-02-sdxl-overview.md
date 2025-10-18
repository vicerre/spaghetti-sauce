---
class: colored-edge colored-edge-vic
---

# Stable Diffusion XL + LoRA

- Like Stable Diffusion, but XL
  - U-Net parameters: 860 million → 2.6 billion
  - Text encoder parameters: 123 million →  817 million
- Hard to give an apples-to-apples comparison due to training methods evolving in parallel

Technical details:

- Base model: [Pony Diffusion V6 XL](https://civitai.com/models/257749/pony-diffusion-v6-xl): (SDXL "retrain" for digital art)
- Workflow: Same as Stable Diffusion 1.5 + LoRA

[sd-pipelines]: https://huggingface.co/docs/diffusers/main/en/api/pipelines/stable_diffusion/overview
[sdxl-arxiv]: https://arxiv.org/abs/2307.01952

<!--
So the next technology to be released is Stable Diffusion XL. The best way to describe it is, well, "Stable Diffusion but with more parameters". There's nothing _really_ new about it from an architecture perspective, to my understanding.

So what does the increase in parameters do for us?
-->
