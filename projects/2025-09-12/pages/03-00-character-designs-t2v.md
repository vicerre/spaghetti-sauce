---
class: flex flex-col
---

# Why character designs?

### Example: text-to-video benchmarks

<div class="flex-auto flex-center">
```mermaid {scale: 1.0}
flowchart TD
    modelscope(["Modelscope<br/>[2023-03-27]<sup><a
            href="https://www.reddit.com/r/StableDiffusion/comments/1244h2c/"
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
    "])
    modelscopeinput["&quot;Will Smith eating spaghetti.&quot; (meme)"]
    modelscopeoutput["
            <video
                autoplay
                height="120"
                loop
                muted
                style="max-height: 100%; max-width: 100%;"
                width="120"
                >
                <source
                    src="/03-04-assets/modelscope-will-smith-eating-spaghetti_2023-03-27.mp4"
                    type="video/mp4"
                />
            </video>
    "]
    modelscopeinput --> modelscope --> modelscopeoutput
    
    kling(["Kling<br/>[2024-06-28]<sup><a
            href="https://www.reddit.com/r/StableDiffusion/comments/1ezpha3/comment/ljmdy0v/"
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
    "])
    klinginput["(unknown)"]
    klingoutput["
        <video
            autoplay
            height="120"
            loop
            muted
            style="max-height: 100%; max-width: 100%;"
            width="214"
            >
            <source
                src="/03-04-assets/kling-will-smith-eating-spaghetti_2024-06-28.mp4"
                type="video/mp4"
            />
        </video>
    "]
    klinginput --> kling --> klingoutput

    veo3(["Veo 3<br/>[2025-05-22]<sup><a
            href="https://twitter.com/_/status/1925495026903380358" 
            style="display: flex; flex-direction: column;"
            target="_blank">[1]</a></sup>
    "])
    veo3input["(unknown)"]
    veo3output["
        <video
            autoplay
            height="135"
            loop
            muted
            style="max-height: 100%; max-width: 100%;"
            width="240"
            >
            <source
                src="/03-04-assets/veo3-will-smith-eating-spaghetti_2025-05-22.webm"
                type="video/webm"
            />
        </video>
        "]
    veo3input --> veo3 --> veo3output
```
</div>

<!--
Another example, and one that's less solved, is that of text-to-video models. In this case, the benchmark is to generate an image of Will Smith eating spaghetti. The first example is a meme, but you can get a sense of how much more fidelity more modern models have.
-->
