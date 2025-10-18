---
class: colored-edge colored-edge-alis
layout: two-cols
---

# Results

- Can inference input images
- (and it has OCR, which is nifty)

::right::

<div class="flex-auto flex-center">
```mermaid {scale: 0.55}
---
config:
    theme: "base"
    themeVariables:
        primaryColor: "#CCFFE6"
        secondaryColor: "#E6FFF3"
        tertiaryColor: "#E6FFF3"
---

    flowchart TD

    nano(["Nano Banana"])
    nanoinput1@{ img: "/09-05-assets/vic-key_2024-08-11.png", h: 128, constraint: "on" }
    nanoinput2@{ img: "/09-05-assets/vic-bust_2024-03-13.png", h: 128, constraint: "on" }
    nanoinput3@{ img: "/09-05-assets/vic-chibi-accessories_2024-11-15.png", h: 128, constraint: "on" }
    nanoinputetc["+ 3 images (as collage)"]
    nanoprompt["&quot;Can you redraw the character in the image attached in the style of a Yu-Gi-Oh card? Use contextual clues to add more depth to the piece beyond the subject itself. Make sure the image is fully-illustrated, including the background. Bonus points if you include rules text for what the card does when played!&quot;"]
    nanooutput@{ img: "/09-05-assets/nanonbanana-vic-puzzle_2025-08-30.png", h: 384, constraint: "on" }

    subgraph inputs
        nanoinput1 ~~~ nanoinput2
        nanoinput3 ~~~ nanoinputetc
    end

    inputs --> nano --> nanooutput
    nanoprompt --> nano
```
</div>

<!--
- It can (almost) write!
- Bonus story: The title of my work is "Spaghetti Ice" (it's not, but that's a long story). When I asked for Nano Banana to draw my character as a manga titled "Spaghetti Ice", the model also generated the word for "Spaghettieis" in Japanese below the English title, AKA it understood the assignment.
-->

<!--

(Skip this slide if low on time.)

Here's another good example of how Gemini and Nano Banana work well to create inferences. In the prompt, I asked the model to use contextual clues to come up with an interesting Yu-Gi-Oh card beyond the character's visual design, and what it came up with is that Vic is good at puzzles.

Okay, first of all, I didn't indicate in my prompt that this character's name was Vic. It read the character's name from the collage, so that was great.

Second, the title it gave him was "Puzzle Prodigy".

Let's take a step back here.

These models:
- Noticed that there was a grid with black and white cells.
- Knew that this icon was a crossword.
- Interpreted it to mean that Vic is a character who is good at puzzles.
- And this is correct.

*clap*

Like wow. This is human-level inference work. It makes me feel good that my character comes across correctly to the model.
-->
