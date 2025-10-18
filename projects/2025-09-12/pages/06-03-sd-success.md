---
class: colored-edge colored-edge-alis
layout: two-cols
---

# Results

- Outputs look good!
- Images have a "smeary" quality
- Lots of trial and error
- Can't prompt for much beyond subject description

::right::

<div class="flex-auto flex items-center justify-center">
```mermaid {scale: 0.75}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart TD

    sd(["Stable Diffusion 1.5"])
    sdinput@{ img: "/06-03-assets/vic-sketch_2022-12-30.png", h: 256, constraint: "on" }
    sdprompt["
        &quot;masterpiece,high quality,best quality,highest detail,4k,((male)),(((high cheekbones))),narrow,thin,long face,pointy,angular,messy hair,((brown hair)),white hair accent,tentatively curious,blue eye,skrunkly,turtleneck,thick winter coat,thick red scarf,hairtie&quot;
    "]
    sdoutput@{ img: "/06-03-assets/anythingv3-vic-output_2022-12-30.png", h: 256, constraint: "on" }

    sdinput --> sd --> sdoutput
    sdprompt --> sd
```
</div>

[frozen-palace-design]: https://victoriaying.tumblr.com/post/69732939309/

<!--
Full prompt:

masterpiece,high quality,best quality,highest detail,4k,((male)),(((high cheekbones))),narrow,thin,long face,pointy,angular,messy hair,((brown hair)),white hair accent,tentatively curious,blue eye,skrunkly,turtleneck,thick winter coat,thick red scarf,hairtie
Negative prompt: nsfw, lowres, (bad anatomy:1.21), bad hands, text, error, missing fingers, extra digit, fewer digits, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, blurry, artist name
Steps: 50, Sampler: Euler a, CFG scale: 15, Seed: 1364821611, Size: 768x768, Model hash: 6569e224, Batch size: 6, Batch pos: 4, Denoising strength: 0.5, Mask blur: 4
-->

<!--
- Instead of "variations", the closest thing SD has is "img2img", where you feed a model an input image and it spits out an output image. This is great for adding more granular control over what your final result should look like. You're still feeding the model text and trying to narrow in on an "approximation", but this was pretty good, really.
- People trying out SD were like superstitious pigeons, where they were sharing these "stock negative prompts" which claimed to get better-quality results.
- This is like how concept artists work. E.g. the environment design artists from Frozen had to draw bajillions of ice palaces to get a vibe of what was the right direction to take.
-->

<!--
In this example, I provided Stable Diffusion some blocks of colors and asked it to draw traits belonging to Vic. This is a much more targeted way of drawing what you're looking for in fewer words, and in the end, you can get some pretty cool results from it! I studied the results from this model to see how to apply the rendering style used to my art.
-->
