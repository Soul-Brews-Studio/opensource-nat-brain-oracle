# Quick Start: Generate Images from Prompts 351-360

**5-Minute Setup to Generate All 10 Images**

---

## Step 1: Understand What You Have (1 min)

You now have 4 files with 10 complete image prompts:

| File | Purpose | Size |
|------|---------|------|
| LEARNING-PATTERNS-prompts-351-360.md | Full specs for all 10 | 22 KB |
| TEMPLATE-image-generation-spec.md | Copy-paste preamble | 9.9 KB |
| INDEX-learning-patterns-351-360.md | Quick reference | 8.4 KB |
| DELIVERY-SUMMARY-351-360.md | Context & next steps | 10 KB |

All files are in:
`/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/`

---

## Step 2: Choose Your Generation Method (2 min)

### FAST (20-45 minutes): Generate all 10 at once
1. Open LEARNING-PATTERNS-prompts-351-360.md
2. For EACH prompt (351-360):
   - Copy the "Prompt" section (150-200 words)
   - Open TEMPLATE-image-generation-spec.md
   - Copy the preamble
   - Combine: Preamble + Prompt text
   - Send to DALL-E / Midjourney / Stable Diffusion
   - Save output as `351-distillation-loop.png`, etc.

### QUALITY (1-2 hours): Generate 3-5, iterate, then rest
1. Generate only 351, 354, 357 (highest priority)
2. Review outputs
3. Adjust preamble if needed
4. Generate remaining 7

### COLLABORATIVE (1 day): Get feedback before generating
1. Print INDEX-learning-patterns-351-360.md
2. Share with team
3. Collect feedback
4. Refine prompts
5. Generate collaborative version

---

## Step 3: Get the Preamble (1 min)

Open: TEMPLATE-image-generation-spec.md

Copy this section (use as-is for all 10 images):

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
```

---

## Step 4: Get Your First Prompt (1 min)

Open: LEARNING-PATTERNS-prompts-351-360.md

Scroll to "351: Distillation Loop"

Copy the "Prompt" section (the 150-200 word visual specification):

```
Monochrome ink-wash background showing a circular distillation
apparatus. At center: a clear vessel spinning slowly, containing
swirling dark ink particles (chaos/raw logs). Around it, four
transformation stations connected by flowing cyan lines:

[... continues for 150-200 words ...]

16:9 composition: Wide vertical vessel in center-bottom, spiraling
flow upward with three transformation points, ending with sealed
document at top-center glowing gold.
```

---

## Step 5: Combine and Generate (variable time)

Combine preamble + prompt for image generator:

```
[PASTE PREAMBLE HERE]

Title: 351 - Distillation Loop

Description:
[PASTE PROMPT HERE]

Additional specifications:
- Save as: results/351-distillation-loop.png
```

**Send to your preferred image generator:**
- DALL-E: https://openai.com/dall-e/
- Midjourney: https://www.midjourney.com/
- Stable Diffusion: Use any Stable Diffusion UI

---

## Step 6: Validate and Save

After generation, verify:
- Format: PNG ✓
- Aspect: 16:9 landscape ✓
- Colors: Monochrome + cyan + gold only ✓
- Thai text: Readable and positioned as design element ✓
- Focal point: Clear and matches composition guidance ✓

Save to:
`/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/`

Use filename format: `[number]-[slug].png`

Example: `351-distillation-loop.png`

---

## The 10 Prompts (Titles Only - See Full Specs in Files)

| # | Title | Save As |
|----|-------|---------|
| 351 | Distillation Loop | 351-distillation-loop.png |
| 352 | Context-Finder First | 352-context-finder-first.png |
| 353 | Subagent Delegation Tree | 353-subagent-delegation-tree.png |
| 354 | Parallel Agent Critique | 354-parallel-agent-critique.png |
| 355 | Two-Round Search Pattern | 355-two-round-search.png |
| 356 | Round-Based Iteration | 356-round-based-iteration.png |
| 357 | Consensus Reveals Truth | 357-consensus-reveals-truth.png |
| 358 | Simple Wins Compound | 358-simple-wins-compound.png |
| 359 | Coherence Over Individual | 359-coherence-over-individual.png |
| 360 | Fast Context Pattern | 360-fast-context-pattern.png |

---

## Batch Generation Shortcut (FASTEST)

If using an API or batch tool (Midjourney, DALL-E API):

1. Create a file with all 10 combined prompts
2. Use batch endpoint
3. Generate all 10 in parallel (20-30 minutes)
4. Download all at once
5. Rename using pattern above

---

## If Something Goes Wrong

### "Colors not showing (no cyan/gold)"
Edit preamble to add:
```
CRITICAL: Apply selective color in cyan (#00FFFF) and gold
(#FFD700) only. All other colors must be monochrome or removed.
```

### "Thai text is unreadable"
Edit preamble to add:
```
Thai text: Render in Noto Sans Thai bold with minimum 20px size.
Position as prominent design element, not small footnote.
```

### "Image doesn't match composition"
Edit specific prompt to add:
```
Composition: [Add more specific guidance from prompt file]
Focal point must be clearly visible at: [specify location]
```

For full troubleshooting, see: TEMPLATE-image-generation-spec.md

---

## Complete Workflow Example

### 1. Copy Preamble (from TEMPLATE file)
```
Create a monochrome ink-wash illustration in 16:9 aspect ratio...
[full preamble]
```

### 2. Copy Prompt (from LEARNING-PATTERNS file)
```
Monochrome ink-wash background showing a circular distillation
apparatus...
[full prompt text]
```

### 3. Combine for Generator
```
[PREAMBLE]

Title: 351 - Distillation Loop

Description:
[PROMPT]
```

### 4. Send to Generator
(DALL-E / Midjourney / Stable Diffusion)

### 5. Receive Image
(PNG file, 16:9 aspect)

### 6. Save With Naming Convention
`351-distillation-loop.png`

### 7. Move to Results Directory
`/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/`

### 8. Repeat for Prompts 352-360

**Total time: 20-45 minutes for all 10**

---

## Pro Tips

**Tip 1: Use Batch Tools**
If your generator supports batch processing, send all 10 at once.
Faster and more consistent rendering.

**Tip 2: Keep Preamble Constant**
Use the SAME preamble for all 10 prompts.
Only change the prompt text (descriptions).

**Tip 3: Review First Few**
Generate 351, 352, 353 first.
Check if they match your vision.
Adjust preamble if needed before full batch.

**Tip 4: Save as You Go**
Don't generate all 10 then save.
Immediately save each image with correct filename.
Reduces risk of losing work.

**Tip 5: Validate Against Specs**
After each generation, check:
- PNG format ✓
- 16:9 aspect ✓
- Monochrome + cyan + gold ✓
- Thai text readable ✓

---

## File Reference Quick Links

Located in:
`/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/`

**For prompts**: Open `LEARNING-PATTERNS-prompts-351-360.md`
**For preamble**: Open `TEMPLATE-image-generation-spec.md`
**For reference**: Open `INDEX-learning-patterns-351-360.md`
**For context**: Open `DELIVERY-SUMMARY-351-360.md`

---

## You're Ready!

All documentation is complete and ready to use.

**Next step**: Choose your generation method (Fast/Quality/Collaborative)

**Time to complete**: 20-45 minutes (Fast) or 1-2 hours (Quality)

**Output**: 10 PNG images, 16:9 aspect, monochrome + cyan + gold style

Let's generate!

---

**Questions?** See DELIVERY-SUMMARY-351-360.md for full documentation.

