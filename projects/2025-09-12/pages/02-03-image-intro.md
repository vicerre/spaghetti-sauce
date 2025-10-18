---
class: colored-edge colored-edge-vic
layout: two-cols
---

# Image Generation Models TL;DR

- Computer software that can generate digital images from a text + optional image prompt

::right::

<div class="flex-auto flex-center">
```mermaid
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart TD
    
    nanobanana(["Nano Banana"])
    input["#quot;A photorealistic image of an astronaut riding a horse#quot;"]
    output@{ img: "/02-03-assets/nanobanana-astronaut-riding-horse_2025-10-15.png", h: 256, constraint: "on" }
    
    input --> nanobanana --> output
```
</div>

[dalle-article]: https://openai.com/index/dall-e-2/

<!--
All right, we've probably seen this talked about this many times over by now, but in case you haven't checked it out, let me give you a summary of image generation models. To simplify greatly, they're machine learning programs that let you turn a text and optional image prompt into an output image.

Image generation models are really powerful when they're asked to draw things that there isn't a lot of data for. For instance, in this example, we asked the model to draw an astronaut riding a horse. This doesn't happen often in real life, but the model is able to derive the right concepts of "astronaut", "riding", and "horse" and put them together into a coherent scene. As we'll soon see, this principle extends to the concept of character designs. 
-->
