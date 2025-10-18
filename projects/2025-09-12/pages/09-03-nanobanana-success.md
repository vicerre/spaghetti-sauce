---
class: colored-edge colored-edge-alis flex flex-col
---

# Results

- Can properly draw Alis 👏

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

    nano(["Nano Banana"])
    nanoinput1@{ img: "/09-03-assets/alis-key_2024-08-11.png", h: 192, constraint: "on" }
    nanoinput2@{ img: "/09-03-assets/alis-chibi-accesories_2024-09-30.png", h: 192, constraint: "on" }
    nanoinput3@{ img: "/09-03-assets/alis-banner_2024-05-21.png",  h: 192, constraint: "on" }
    nanoinputetc["+ 7 images (as collage)"]
    nanoprompt["2 prompts"]
    nanooutput1@{ img: "/09-03-assets/nanobanana-alis-pokemon_2025-08-30.png", h: 256, constraint: "on" }
    nanooutput2@{ img: "/09-03-assets/nanobanana-alis-disney_2025-08-30.png", h: 256, constraint: "on" }

    subgraph inputs
        nanoinput1 ~~~ nanoinput2
        nanoinput3 ~~~ nanoinputetc
    end

    subgraph outputs
        nanooutput1 ~~~ nanooutput2
    end

    inputs ---> nano ---> outputs
    nanoprompt --> nano
```
</div>

<!--
Well, for one, it can draw Alis correctly. It doesn't simply copy-paste the drawings I fed in as input, and it doesn't get his gender wrong. This is a win in my books!

Okay, but really, the results are really good, actually. Like, there's no smeary quality or accidental overfitting. And it's almost solved the problem of hands, too. And I don't need to generate a dozen results to cherry-pick one good result out of these, it just does it in one shot, which theoretically is more resource-efficient.
-->
