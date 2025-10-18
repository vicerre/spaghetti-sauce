---
class: colored-edge colored-edge-solana flex flex-col
---

# Video generation models?

- A video is just a moving image, right? 🧠

<div class="flex-auto flex-center">
```mermaid {scale: 0.85}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#FDCFCF"
        secondaryColor: "#FEE7E7"
        tertiaryColor: "#FEE7E7"
---

    flowchart LR

    veo(["Veo 2"])
    veoinput1@{ img: "/10-04-assets/solana-key_2024-02-08.png", h: 128, constraint: "on" }
    veoinput2@{ img: "/10-04-assets/solana-key-front_2025-08-01.png", h: 128, constraint: "on" }
    veoinput3@{ img: "/10-04-assets/solana-key-back_2025-08-01.png", h: 128, constraint: "on" }

    veoprompt["2 prompts"]
    veooutput1["
        <video
            autoplay
            loop
            muted
            style="max-height: 100%; max-width: 100%;"
            width="360"
        >
            <source src="/10-04-assets/veo3-solana-dance_2025-08-07.mp4" type="video/mp4" />
        </video>
        "]
    veooutput2["
        <video
            autoplay
            loop
            muted
            style="max-height: 100%; max-width: 100%;"
            width="360"
        >
            <source src="/10-04-assets/veo3-solana-train_2025-08-07.mp4" type="video/mp4" />
        </video>
        "]

    subgraph inputs
        direction TB
        veoinput1 ~~~ veoinput2
        veoinput1 ~~~ veoinput3
    end

    subgraph outputs
        direction TB
        veooutput1 ~~~ veooutput2
    end

    inputs ---> veo --> outputs
    veoprompt --> veo
```
</div>

[ToonCrafter]: https://doubiiu.github.io/projects/ToonCrafter/

<!--
- I'd need another five years of full-time practice to get to this level of making animation.
- I used the video feature to make turnarounds of my characters so I had a better idea of how to draw them from different angles.
- The model has a really good idea of volumes. I'm impressed by how the model knows when Solana's tail is obstructed by her legs and how that doesn't phase in and out of existence.
- Like with Nano Banana, the use of synthetic training data plagues Solana here. It draws Solana with her "hair backwards.
- Google Veo 2 is limited in how many images you can feed in as an "ingredient" to the video.
- Google Veo doesn't let you generate audio if you're passing in ingredients. I'd love to hear what it thinks these characters sound like. Maybe soon!
-->

<!--
I've also experimented with image-to-video technologies, too. Here's an example where I used Google Veo to create animations of Solana. Absolutely amazing technology, really technically impressive, would love to go into detail. Again, ask me after the presentation or check out the slide notes for more thoughts on this.
-->
