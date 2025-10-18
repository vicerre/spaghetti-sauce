---
class: colored-edge colored-edge-alis flex flex-col
---

# Why character designs?

### Example: text-to-image benchmarks

<div class="flex-auto flex-center">
```mermaid {scale: 0.7}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart TD

    dalle(["DALL·E 2<br/>[2022-04-06]<sup><a
            href="https://web.archive.org/web/20220406141035/https://openai.com/dall-e-2/"
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
        "])
    dalleinput["&quot;A photorealistic image of an astronaut riding a horse&quot;"]
    dalleoutput@{ img: "/03-03-assets/dalle2-astronaut-riding-horse_2022-04-06.webp", h: 256, constraint: "on" }
    dalleinput --> dalle --> dalleoutput
    
    sdxl(["Stable Diffusion XL 1.0<br/>[2023-08-17]
        <sup><a
            href="https://commons.wikimedia.org/wiki/File:Astronaut_Riding_a_Horse_(SDXL).jpg"
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
    "])
    sdxlinput["&quot;a photograph of an astronaut riding a horse&quot;"]
    sdxloutput@{ img: "/03-03-assets/sdxl-astronaut-riding-horse_2023-08-17.jpg", h: 256, constraint: "on" }
    sdxlinput --> sdxl --> sdxloutput
    
    flux(["Flux Pro<br/>[2024-12-13]<sup><a
            href="https://commons.wikimedia.org/wiki/File:Astronaut_Riding_a_Horse_(FLUX_1.1_Pro).webp"
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
    "])
    fluxinput["&quot;a photograph of an astronaut riding a horse on moon&quot;"]
    fluxoutput@{ img: "/03-03-assets/flux-astronaut-riding-horse_2024-12-13.webp", h: 256, constraint: "on" }
    fluxinput --> flux --> fluxoutput

    nano(["Nano Banana<br/>[2025-10-16]"])
    nanoinput["&quot;A photorealistic image of an astronaut riding a horse&quot;"]
    nanooutput@{ img: "/03-03-assets/nanobanana-astronaut-riding-horse_2025-10-15.png", h: 256, constraint: "on" }
    nanoinput --> nano --> nanooutput
```
</div>

<!--
For text-to-image, a common benchmark is to draw an astronaut riding a horse. As mentioned previously, this benchmark was originally pretty difficult for image generation software due to the "imagination" needed to produce this result, but nowadays, image generation models are pretty solid at handling this.
-->
