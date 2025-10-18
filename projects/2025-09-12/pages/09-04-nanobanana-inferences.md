---
class: colored-edge colored-edge-alis flex flex-col
---

# Results

- Can inference input images

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

    flowchart LR

    nano(["Nano Banana"])
    nanoinput@{ img: "/09-04-assets/vic-chibi_2024-11-15.png", h: 256, constraint: "on" }
    nanoprompt["&quot;turn this character into a character 1/6 figurine, behind it place a box of the figurine with the characters image printed on it, and a computer showing the blender modeling process on the screen in the background, add a round plastic base with the figure standing on it, the scene is indoors&quot;"]
    nanooutput@{ img: "/09-04-assets/nanonbanana-vic-figurine-2025-08-30.png", h: 384, constraint: "on" }

    nanoinput ---> nano --> nanooutput
    nanoprompt --> nano
```
</div>

[nano-banana-figurine]: https://www.creativebloq.com/ai/ai-art/heres-how-people-are-making-those-viral-3d-figurines
[tangled-nose-right]: https://tv.getyarn.io/yarn-clip/f4db0ea4-d6dc-413e-bdb7-fac84e1c19b0/gif

<!--
It's also really good at making inferences too, beyond what I had seen from Stable Diffusion.

Like in this generation, I asked the model to redraw this drawing of Vic as a figurine, including the box it came from and the 3D model the figurine is based on.

For it to do so, it needs to know the materials for each element in the scene. The 3D model looks like it's plastic, the drawing on the box looks like it's printed on paper, and the 3D model looks like it has good topology.

There are some other really good details here too:
 - It understands from the drawing that Vic is wearing a jacket, and that the trim of his jacket is a fleece, so it gave the figurine a fleecy-looking texture on the trim of the jacket.
 - Likewise, it also emphasized the fold in his scarf.
 - Also, if you look at the legs, there's a really subtle rotation on the figurine that shows the model understands how the drawing works in 3D space.

And yet, it gets the nose wrong.
-->
