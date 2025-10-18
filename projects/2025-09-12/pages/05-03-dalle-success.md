---
class: colored-edge colored-edge-vic flex flex-col
---

# Results

- Output images have qualities of input images 👍

<div class="flex-auto flex-center">
```mermaid {scale: 1}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart LR

    dalle(["DALL·E 2"])
    dalleinput@{ img: "/05-03-assets/solana-headshot_2022-09-04.png", h: 128, constraint: "on" }
    dalleoutput1@{ img: "/05-03-assets/dalle2-solana-variation-1_2022-09-15.png", h: 128, constraint: "on" }
    dalleoutput2@{ img: "/05-03-assets/dalle2-solana-variation-2_2022-09-15.png", h: 128, constraint: "on" }
    dalleoutput3@{ img: "/05-03-assets/dalle2-solana-variation-3_2022-09-15.png", h: 128, constraint: "on" }
    dalleoutput4@{ img: "/05-03-assets/dalle2-solana-variation-4_2022-09-15.png", h: 128, constraint: "on" }

    subgraph outputs
        dalleoutput1 ~~~ dalleoutput2
        dalleoutput3 ~~~ dalleoutput4
    end
    
    dalleinput --> dalle --> outputs
```
</div>

<!--
- It might not look like it at the time, but being able to generate images that resembled input images was mind-blowing to me.
- Like, my input images of the time weren't great, and the output images definitely feel like they're clumsy, but at the time, I was just jazzed that I could see my characters at all. It's a bit like seeing a baby say its first word.
- Strictly speaking, the "image variations" feature on DALL·E isn't true image-to-image.
- Note at this time that my own art skills were not up to par.
-->

<!--
I mean hey, for 2022, this was amazing. Compared to the input images, the output images look pretty rough, but you can tell that the quote-unquote image-to-image used elements of the source images to produce elements of the output images.

As mentioned before, my characters weren't really possible to generate with text-to-image, so seeing anything that looks close was pretty mind-blowing.
-->
