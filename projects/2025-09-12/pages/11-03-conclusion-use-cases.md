---
class: colored-edge colored-edge-vic flex flex-col
---

# What do image generation models do for me?

- Positive feedback loop: better human art → better training data for image generation models → better human art

<div class="flex-auto flex-center">
```mermaid {scale: 0.9}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#DDCCFF"
        secondaryColor: "#EEE6FF"
        tertiaryColor: "#EEE6FF"
---

    flowchart LR

    human1@{ img: "/11-03-assets/vic-key_2023-07-05.png", label: "human-drawn", h: 128, constraint: "on" }
    ai2@{ img: "/11-03-assets/counterfeit-vic-marshmallow_2023-12-23.png", label: "AI-generated", h: 128, constraint: "on" }
    human3@{ img: "/11-03-assets/vic-bust_2024-03-13.png", label: "human-drawn", h: 128, constraint: "on" }
    ai4@{ img: "/11-03-assets/pony-vic-turnaround-2024-02-20.png", label: "AI-generated", h: 128, constraint: "on" }
    human5@{ img: "/11-03-assets/vic-key_2025-08-01.png", label: "human-drawn", h: 128, constraint: "on" }

    human1 --> ai2 ---> human3 ---> ai4 ---> human5
```
</div>

<!--
- The bust of Vic? Inspired by AI.
- The chibi art of the three? Inspired by AI.
- The settei art of the three? Motivated by AI.
- Overall, AI has helped me figure out the gaps in my understanding of art.
-->

<!--
AI-generated images inspire my hand-drawn art, which I feed back into AI models to help inspire my later art. It acts as a positive feedback loop where I can draw more clearly what the results in my head are.

In this example, you can see how I've iteratively developed my character design drawings using AI-generated images to help figure out what I'm missing in my hand-drawn art.
-->
