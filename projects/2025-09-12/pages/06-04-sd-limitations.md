---
class: colored-edge colored-edge-alis flex flex-col
---

# Results

- Can't prompt for much if tokens are dedicated to visual description
- Prone to hallucinations

<div class="flex-auto flex-center">
```mermaid {scale: 0.6}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart LR

    sd(["Stable Diffusion 1.5"])
    sdinput@{ img: "/06-04-assets/vic-headshot_2022-10-26.png", h: 256, constraint: "on" }
    sdprompt["&quot;masterpiece,high quality,best quality,highest detail,4k,((male)),(((high cheekbones))),narrow,thin,long face,pointy,angular,messy hair,((brown hair)),white hair accent,tentatively curious,blue eye,snow,turtleneck,thick winter coat,thick red scarf&quot;"]
    sdoutput1@{ img: "/06-04-assets/anythingv3-vic_2022-12-29.png", h: 256, constraint: "on" }
    sdoutput2@{ img: "/06-04-assets/anythingv3-vic-veil_2022-11-29.png", h: 256, constraint: "on" }
    sdoutput3@{ img: "/06-04-assets/anythingv3-vic-plants_2022-12-29.png", h: 256, constraint: "on" } 
    sdoutput4@{ img: "/06-04-assets/anythingv3-vic-flowers_2022-12-29.png", h: 256, constraint: "on" }

    subgraph outputs
        sdoutput1 ~~~ sdoutput2
        sdoutput3 ~~~ sdoutput4
    end

    sdinput --> sd --> outputs
    sdprompt --> sd
```
</div>

[stable-diffusion-token-limit]: https://github.com/huggingface/diffusers/issues/2136

<!--
- Token limitation: 77 positive + negative
-->

<!--
Image-to-image has limitations, though. Since the model doesn't actually know how to adapt certain parts of the base image, it tends to make stuff up.

In this example, the model ended up "hallucinating" a bunch of random elements in Vic's hair despite the prompt not indicating anything there. For example, we've got some plants and a veil and what looks like some glowy flower-like things.

This is hard to correct for, too, since the token limit on the model is only 77, and you can't spend that limit asking for corrections if you're spending it on just describing what it is you're looking for.
-->
