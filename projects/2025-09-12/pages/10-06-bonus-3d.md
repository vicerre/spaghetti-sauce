---
class: colored-edge colored-edge-solana
layout: two-cols
---

# 3D modeling models?

- A 3D model is just some math that produces an infinite # of 2D images, right? 🌌

<div class="flex-auto flex-center">
```mermaid {scale: 1.0}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#FDCFCF"
        secondaryColor: "#FEE7E7"
        tertiaryColor: "#FEE7E7"
---

    flowchart LR

    classDef empty height: 0, width: 0

    sparc3d(["Sparc3D"])
    sparc3dinput@{ img: "/10-06-assets/vic-key_2024-08-11.png", h: 256, constraint: "on" }
    sparc3doutput[" "]:::empty
    
    sparc3dinput --> sparc3d --> sparc3doutput
```
</div>

::right::

<!-- Imported at index.html -->

<model-viewer
    ar
    camera-controls
    interaction-prompt="none"
    src="/10-06-assets/sparc3d-vic.glb"
    shadow-intensity="1"
    style="background-color: #FDCFCF; height: 100%; width: 100%;"
    touch-action="pan-y"
    >
</model-viewer>

[marge-i-just-think-they-re-neat]: https://knowyourmeme.com/memes/i-just-think-theyre-neat
[sparc3d]: https://sparc3d.org/playground

<!--
And just because I just think it's neat, I've also played around with image to 3D modeling models, too.
-->
