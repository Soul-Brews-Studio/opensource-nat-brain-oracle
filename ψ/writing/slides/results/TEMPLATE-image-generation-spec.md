# Image Generation Template for Learning Patterns (351-360)

Use this template when sending prompts to DALL-E, Midjourney, or other image generators.

---

## Standard Preamble (Copy before each prompt)

```
Create a monochrome ink-wash illustration in 16:9 aspect ratio (landscape).

Style requirements:
- Base: Monochrome ink-wash effect (hand-drawn, traditional aesthetic)
- Energy/Flow elements: Cyan color (#00FFFF or similar bright cyan)
- Completion/Decision elements: Gold color (#FFD700 or warm gold)
- No other colors except monochrome, cyan, and gold

Typography:
- Thai text: Use Noto Sans Thai font for authenticity
- Secondary Thai fonts acceptable: Prompt, Kanit, or Sarabun
- English text: Use Noto Sans
- All text rendered as design elements, not overlays

Format:
- Output: PNG (high quality, lossless)
- Aspect Ratio: 16:9 (1920x1080 minimum, 3840x2160 preferred)
- No branding, watermarks, or signatures

Visual principles:
- Avoid corporate aesthetic
- Embrace imperfection and hand-drawn quality
- Use fractals and geometric patterns to suggest self-similarity
- Thai text should flow naturally as part of the composition
- Monochrome background should have subtle texture (paper, canvas, parchment)
```

---

## Prompt Template for Each Image

Copy this template for each of the 10 prompts (351-360):

```
[INSERT PREAMBLE ABOVE]

Title: [351-360 and English title]

Description:
[Copy the "Prompt" section (150-200 words) from LEARNING-PATTERNS-prompts-351-360.md]

Additional specifications:
- Composition: 16:9 (landscape orientation)
- Thai text integration: [Specific instruction from prompt - e.g., "Thai labels on outer arc"]
- Color zones: [Specific instruction - e.g., "Left side faded gray, right side bright cyan"]
- Focal point: [From composition guidance - e.g., "Center glowing gold point"]

Quality checklist:
□ Monochrome ink-wash base with subtle texture
□ Cyan used only for energy/flow elements
□ Gold used only for completion/decision points
□ Thai text rendered as calligraphic design elements
□ Aspect ratio exactly 16:9
□ PNG format, high resolution
```

---

## Quick Reference: Color & Style Usage

### When to Use CYAN (#00FFFF or similar)
- Flowing lines (energy, connection, movement)
- Expansion patterns (spreading outward)
- Search rays or beams
- Convergence lines (multiple toward one point)
- Suggestions of AI/digital process
- Dynamic elements suggesting "now happening"

**Prompts emphasizing cyan**: 352, 354, 355, 356, 360

### When to Use GOLD (#FFD700 or warm gold)
- Decision points marked
- Completion or endpoint
- Truth revealed or clarity achieved
- Highest-value items or checkmarks
- Culmination of process
- Static moments of achievement
- Consensus or agreement markers

**Prompts emphasizing gold**: 351, 354, 357, 358, 359

### Monochrome Ink-Wash (Foundation)
- All base structure and primary elements
- Shading and depth variation
- Detail work and texture
- Background elements
- Most of the visual composition (70-80%)

**Apply monochrome throughout all prompts as the dominant visual approach**

---

## File Naming Convention

After image generation, name files as:

```
[number]-[slug].png

Examples:
351-distillation-loop.png
352-context-finder-first.png
353-subagent-delegation-tree.png
354-parallel-agent-critique.png
355-two-round-search.png
356-round-based-iteration.png
357-consensus-reveals-truth.png
358-simple-wins-compound.png
359-coherence-over-individual.png
360-fast-context-pattern.png
```

Save all files to:
```
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/
```

---

## Example: Fully Rendered Prompt for Image Generator

Here's a complete example showing how to combine preamble + prompt + specifications:

```
Create a monochrome ink-wash illustration in 16:9 aspect ratio (landscape).

Style requirements:
- Base: Monochrome ink-wash effect (hand-drawn, traditional aesthetic)
- Energy/Flow elements: Cyan color (#00FFFF or similar bright cyan)
- Completion/Decision elements: Gold color (#FFD700 or warm gold)
- No other colors except monochrome, cyan, and gold

Typography:
- Thai text: Use Noto Sans Thai font for authenticity
- Secondary Thai fonts acceptable: Prompt, Kanit, or Sarabun
- English text: Use Noto Sans
- All text rendered as design elements, not overlays

Format:
- Output: PNG (high quality, lossless)
- Aspect Ratio: 16:9 (1920x1080 minimum, 3840x2160 preferred)
- No branding, watermarks, or signatures

Title: 351 - Distillation Loop

Description:
Monochrome ink-wash background showing a circular distillation apparatus. At center: a clear vessel spinning slowly, containing swirling dark ink particles (chaos/raw logs). Around it, four transformation stations connected by flowing cyan lines:

1. Bottom-left: Scattered papers and notes (raw logs) - dark, chaotic
2. Bottom-right: Handwritten notes crystallizing into patterns - cyan threads showing connections
3. Top-right: Gold highlights revealing core patterns - refined essence glowing
4. Top-left: CLAUDE.md document sealed with gold wax - the compressed wisdom

Vertical arrows show upward flow: messy → organized → meaningful → crystallized. Fractals at edges suggest recursive distillation. Subtle repeating Thai text "บันทึก" (logs) fades into "ความรู้" (knowledge) fades into "ภูมิปัญญา" (wisdom) at the top. Gold dust particles float between each stage.

Composition: 16:9 (landscape). Wide vertical vessel in center-bottom, spiraling flow upward with three transformation points, ending with sealed document at top-center glowing gold.

Thai text integration: Four Thai labels at each transformation station, arranged vertically upward. Font: Kanit for station labels.

Color zones:
- Background: Monochrome ink-wash with subtle paper texture
- Energy flow: Cyan (#00FFFF) for spiraling lines connecting stages
- Completion: Gold (#FFD700) for vessel glow, wax seal, dust particles
- Text: Dark gray/black for readability against monochrome background

Focal point: Central glowing vessel with upward spiral, culminating in gold-glowing CLAUDE.md document at top-center.

Quality checklist:
□ Monochrome ink-wash base with subtle texture
□ Cyan used for spiral flow lines and connection threads
□ Gold used for vessel highlights, dust, seal, document glow
□ Thai text rendered as calligraphic labels at each station
□ Aspect ratio exactly 16:9
□ PNG format, high resolution (3840x2160 preferred)
```

---

## Batch Generation Options

### Option 1: Sequential Generation
Generate one image at a time, reviewing before next.
- Pros: Quality control, can adjust based on results
- Cons: Slower, requires multiple interactions
- Timeline: 1-2 hours for all 10

### Option 2: Parallel Batch
Send 3-5 prompts simultaneously to same generator.
- Pros: Faster turnaround
- Cons: Less individual fine-tuning
- Timeline: 30-45 minutes for all 10

### Option 3: Multi-Generator Approach
Split prompts across Midjourney, DALL-E, Stable Diffusion.
- Pros: Fastest, different tools may handle styles differently
- Cons: Need to coordinate, verify consistency
- Timeline: 20-30 minutes if parallel

**Recommendation**: Option 2 (parallel batch) - good balance of speed and quality control.

---

## Troubleshooting & Adjustments

If generated images don't match specifications:

### Issue: "Colors not appearing (no cyan/gold)"
Solution: Add to preamble: "CRITICAL: Apply selective color in cyan (#00FFFF) and gold (#FFD700) only. All other colors must be monochrome or removed."

### Issue: "Thai text rendering poorly / hard to read"
Solution: Specify font more explicitly. Try: "Thai text in Noto Sans Thai bold, rendered as design element with 20-25px minimum size."

### Issue: "Composition too busy / not enough negative space"
Solution: Add to specific prompt: "Emphasize negative space and simplicity. 60% of image should be clean ink-wash background with no details."

### Issue: "Looks too corporate / needs more hand-drawn quality"
Solution: Add to preamble: "Emulate traditional watercolor ink painting. Include visible brushstrokes, paper texture, slight imperfections showing human hand. Avoid digitally-perfect edges."

### Issue: "Cyan/Gold not visible enough"
Solution: Increase saturation specification: "Use vibrant cyan (#00FFFF) and warm gold (#FFD700) for maximum contrast against monochrome base."

---

## Validation Checklist After Generation

For each generated image (351-360), verify:

- [x] File is PNG format
- [x] Aspect ratio is exactly 16:9 (landscape)
- [x] Monochrome ink-wash base is visible and textured
- [x] Cyan (#00FFFF area) appears in energy/flow elements
- [x] Gold (#FFD700 area) appears in completion/decision points
- [x] Thai text is readable and positioned as design element
- [x] English text (if any) is rendered clearly
- [x] Composition follows 16:9 landscape (not cropped/distorted)
- [x] No watermarks, branding, or signatures visible
- [x] File named correctly (e.g., 351-distillation-loop.png)
- [x] Saved to correct directory (/ψ/writing/slides/results/)

If any item fails, request regeneration or adjustment.

---

## Source Reference

All prompts reference these core CLAUDE.md principles:

1. **351 - Distillation Loop**: Knowledge Distillation Loop (learning pattern)
2. **352 - Context-Finder First**: Subagent delegation to save context
3. **353 - Delegation Tree**: Subagent capabilities by role
4. **354 - Parallel Critique**: Consensus validation from 10 perspectives
5. **355 - Two-Round Search**: Fast broad → deep dive pattern
6. **356 - Round-Based Iteration**: Discovery → Convergence → Refinement
7. **357 - Consensus Reveals Truth**: 4+ agents flagging same issue = truth
8. **358 - Simple Wins Compound**: Small improvements with compound growth
9. **359 - Coherence Over Individual**: System harmony > local optimization
10. **360 - Fast Context Pattern**: Skip discovery when goal is clear

See full specifications in:
`/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/LEARNING-PATTERNS-prompts-351-360.md`

---

End of template.

