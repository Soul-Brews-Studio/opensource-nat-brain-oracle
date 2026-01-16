# Image Generation Guide: Anti-Patterns 371-380

**Quick Navigation**: [Start Here] → [Detailed Prompts] → [Checklists] → [Integration]

---

## Step 1: Choose Your Tool (5 minutes)

### DALL-E 3 (Recommended for Accuracy)
**Best for**: Text rendering, bilingual content, quick turnaround
**Strengths**: 
- Excellent text placement (Thai + English)
- Consistent style across batch
- Fast (1 image per minute)
**Weaknesses**: 
- Less artistic control over final look
- Fewer iterations included in API
**Time per image**: 1-2 minutes
**Total time for 10**: 30-60 minutes

### Midjourney (Recommended for Quality)
**Best for**: Artistic interpretation, unique visual style, iterations
**Strengths**:
- Beautiful organic quality
- Rich texture and depth
- Iteration/refinement friendly
**Weaknesses**:
- Harder to render clean text
- May require post-processing for Thai text
- Slower (5-10 minutes per image)
**Time per image**: 5-10 minutes
**Total time for 10**: 1-2 hours

### Hybrid Approach (Best Overall)
1. Generate base images with Midjourney (1-2 hours)
2. Add text overlay using DALL-E 3 or Photoshop (30 minutes)
3. Verify style consistency (30 minutes)
**Total time**: 2-2.5 hours, highest quality

---

## Step 2: Prepare Your Prompts (10 minutes)

**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/prompts-371-380-anti-patterns.md`

**Option A - Copy One by One**:
1. Open prompts-371-380-anti-patterns.md
2. Scroll to Prompt 371
3. Copy the "Prompt" section (150-200 word paragraph)
4. Paste into your AI tool
5. Repeat for 372-380

**Option B - Batch Processing** (if using API):
1. Extract all 10 prompt texts
2. Create batch file for DALL-E API
3. Process all at once
4. Download results

**What to include in tool**:
```
[Copy the detailed visual description from the "Prompt" section]

Style requirements:
- Monochrome ink-wash base
- Cyan accents (energy/flow/warnings)
- Gold highlights (decisions/consequences)
- 16:9 aspect ratio
- Include Thai + English text as shown
```

---

## Step 3A: Generate with DALL-E 3

### Setup
1. Open [ChatGPT Plus](https://chat.openai.com) or [DALL-E directly](https://openai.com/dall-e-3/)
2. Ensure "DALL-E 3" is selected

### For Each Prompt (371-380)

```
1. Copy entire prompt from prompts-371-380-anti-patterns.md
2. Paste into ChatGPT
3. Request specific modifications:
   "Generate this image with 16:9 aspect ratio, PNG format, high quality"
4. Download as PNG
5. Rename to: [NUMBER]-[slug].png
   Example: 371-over-assumption-under-urgency.png
6. Save to: ψ/writing/slides/results/
7. Move to next prompt
```

### Example Modification Request
```
DALL-E, please generate this with:
- Aspect ratio: 16:9 (widescreen)
- Resolution: 2560x1440 or higher
- Format: PNG
- Style: Professional, publication-ready
- Text: Keep Thai + English visible and clear
```

### Tips for DALL-E 3
- Request revisions if text is unclear
- Ask for "sharper" or "softer" if needed
- Use "higher contrast" if cyan/gold is too subtle
- Do NOT ask to change the core visual metaphor

---

## Step 3B: Generate with Midjourney

### Setup
1. Join [Midjourney Discord](https://discord.gg/midjourney)
2. Access `/imagine` command in any channel

### For Each Prompt (371-380)

```
1. Prepare the prompt (copy from prompts-371-380-anti-patterns.md)
2. Add Midjourney parameters:
   /imagine [PROMPT] --ar 16:9 --q 2 --s 750

3. Where:
   --ar 16:9 = aspect ratio (widescreen)
   --q 2 = quality (highest)
   --s 750 = style weight (detailed)

4. Wait 60 seconds for result
5. Select "U1" (upscale) for best quality
6. Download PNG
7. Post-process for text if needed
8. Rename and save to ψ/writing/slides/results/
```

### Example Midjourney Command
```
/imagine Monochrome ink-wash foundation showing a runner 
sprinting toward a hidden cliff through mist. Cyan energy 
streaks flow around the figure. Gold circle warns of cliff 
edge but arrives too late. Ink-wash shadows above hint at 
consequences. Bottom text: "SPEED ≠ SEEING" with Thai: 
"ความเร็ว ≠ การมองเห็น". Artistic, professional, 16:9 
--ar 16:9 --q 2 --s 750
```

### Tips for Midjourney
- Add "style: ink wash" if not prominent
- Request "variations" to iterate on style
- Use "U2" or "U3" if first upscale isn't perfect
- Ask for "remixed" version if color emphasis is off
- Consider generating without text, then adding via Photoshop

---

## Step 4: Verify Quality (30 minutes)

**Checklist for Each Image**:

```
[ ] Monochrome ink-wash base is prominent
[ ] Cyan accents visible and purposeful
[ ] Gold highlights visible and prominent
[ ] 16:9 aspect ratio (no distortion)
[ ] Thai text readable and properly positioned
[ ] English text readable and properly positioned
[ ] PNG format, high resolution (2K minimum)
[ ] File naming matches pattern: [NUMBER]-[slug].png
[ ] Style consistent with 264-268 reference images
[ ] Dark/cautionary tone (not cheerful)
[ ] Core visual metaphor is clear at thumbnail size
```

**Comparison Against Reference**:
- Open: 264-broadcast-vs-unicast.png
- Compare: Color balance, text placement, ink-wash style
- Adjust: If significantly different, request regeneration

**Common Issues & Fixes**:

| Issue | Fix |
|-------|-----|
| Text too small | Request "larger text" regeneration |
| Cyan too dim | Request "more vivid cyan accents" |
| Gold not visible | Request "bright gold highlights" |
| Wrong aspect ratio | Crop or regenerate with --ar 16:9 |
| Thai text corrupted | Use Photoshop to add text overlay |
| Too bright/colorful | Request "darker, more monochrome base" |

---

## Step 5: Organize Files (10 minutes)

### File Naming Convention
```
[NUMBER]-[slug].png
371-over-assumption-under-urgency.png
372-context-confidence-override.png
373-force-push-danger.png
374-premature-abstraction.png
375-subagent-not-always-needed.png
376-silent-failure-hidden.png
377-averaging-scores-blindness.png
378-zombie-agent-problem.png
379-merge-conflict-chaos.png
380-rate-limit-crash.png
```

### Save Location
```
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/

Create folder if needed:
mkdir -p "ψ/writing/slides/results/"

Verify with:
ls -lh ψ/writing/slides/results/37*png
```

---

## Step 6: Verify Against Checklist (5 minutes)

**After all 10 generated, run verification**:

```bash
cd /Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/slides/results/

# Count images
ls -1 37*.png | wc -l
# Should output: 10

# Check file sizes (should be similar)
ls -lh 37*.png
# Look for 2-4 MB per image (PNG compressed)

# Verify naming
ls 37*.png | while read f; do
  echo "$f: $(identify -format '%wx%h' $f 2>/dev/null || echo 'CORRUPT')"
done
# All should show 16:9 aspect (e.g., 1920x1080, 2560x1440)
```

---

## Step 7: Final Review (30 minutes)

### Style Consistency Check
1. Open all 10 images in preview (slideshow mode)
2. Do they feel like a cohesive set?
3. Is monochrome + cyan + gold consistent?
4. Are text sizes and placement similar?

### Visual Impact Check
1. At thumbnail size (100x60px), can you tell the story?
2. Is the warning/caution clear visually?
3. Would this work in a presentation?

### Technical Check
1. All PNG format? `file 37*.png | grep PNG`
2. All 16:9? Use `identify 37*.png`
3. All high quality? Check file size 2-4 MB

---

## Step 8: Integration (varies by use case)

### For Presentation Deck
- Create slides with one image per slide
- Add 3-5 discussion points below each
- Use QUICK-REFERENCE-371-380.md for talking points

### For Workshop
- Print all 10 at A3 size or larger
- Create discussion cards with questions
- Facilitate: "What makes this warning real?"

### For Documentation
- Create wiki page with all 10
- Add categories: Design, Operations, Decisions
- Link to related CLAUDE*.md files

### For Gallery
- Create image gallery on web/Figma
- Add Thai + English descriptions
- Cross-reference to learnings

---

## Timeline Estimates

### Fast Path (Minimal Effort)
- Tool choice: DALL-E 3 (5 min)
- Prompt preparation: (5 min)
- Generation: 30-60 min (1 per minute)
- Verification: 15 min
- **Total: ~2 hours**

### Quality Path (Best Results)
- Tool choice: Midjourney hybrid (5 min)
- Reference study: 15 min (264-268 images)
- Prompt preparation: 15 min
- Generation: 1-2 hours (iteration friendly)
- Post-processing: 30 min (text cleanup)
- Verification: 30 min
- **Total: ~3-3.5 hours**

### Workshop Ready Path (Full Integration)
- Generate images: 2-3 hours (using quality path)
- Create presentation deck: 2 hours
- Print high-res versions: 1 hour
- Design discussion cards: 1 hour
- **Total: ~6-7 hours (over 1-2 days)**

---

## Troubleshooting

### Text Not Rendering Correctly
**Problem**: Thai or English text is blurry/corrupted
**Solutions**:
1. Request regeneration with "clearer text"
2. Post-process: Use Photoshop/GIMP to add text overlay
3. Try Canva: Generate image first, then add text in Canva

### Colors Not Right
**Problem**: Cyan too dim, gold not visible, too colorful overall
**Solutions**:
1. Request: "Stronger cyan accents and gold highlights"
2. Request: "Darker monochrome base, more dramatic color contrast"
3. Use post-processing: Increase cyan saturation, boost gold

### Aspect Ratio Wrong
**Problem**: Generated 1:1 or 4:3 instead of 16:9
**Solutions**:
1. DALL-E: Request "16:9 aspect ratio" in follow-up
2. Midjourney: Use `--ar 16:9` parameter
3. Post-process: Crop to 16:9 or pad with ink-wash background

### Too Many Visual Details
**Problem**: Style too busy, loses the core metaphor
**Solutions**:
1. Request: "Simpler composition, more negative space"
2. Request: "Focus on the central metaphor, minimize details"
3. Regenerate with more specific guidance on focal point

### Feeling Disconnected From Style
**Problem**: Doesn't match 264-268 reference images
**Solutions**:
1. Reference image alongside prompt
2. Request: "Match the style of [reference image]"
3. Try different tool (DALL-E vs Midjourney)
4. Use post-processing to adjust colors/contrast

---

## Success Indicators

When you're done, you should have:

1. **10 PNG images** in ψ/writing/slides/results/
2. **Consistent style** (monochrome + cyan + gold)
3. **Clear text** (Thai + English readable)
4. **16:9 ratio** (no distortion)
5. **High resolution** (2K minimum, PNG compressed)
6. **Dark tone** (cautionary, not cheerful)
7. **Coherent metaphors** (clear at thumbnail size)
8. **Publication ready** (could use in presentations immediately)

---

## Next Steps After Generation

1. **Update INDEX**: Add to INDEX-visual-prompts.md
2. **Create gallery**: Make browsable collection
3. **Link to learning**: Cross-reference CLAUDE_lessons.md
4. **Plan usage**: Presentation, workshop, or documentation?
5. **Collect feedback**: Share with collaborators

---

## Support Files

If you get stuck, refer to:

| File | Purpose |
|------|---------|
| `prompts-371-380-anti-patterns.md` | Detailed prompts (copy these) |
| `QUICK-REFERENCE-371-380.md` | Understanding the vision |
| `SUMMARY-371-380.txt` | Quick facts + verification |
| `INDEX-371-380.md` | Full navigation + integration guide |
| `GENERATION-GUIDE-371-380.md` | This file (step-by-step) |

---

**Ready to generate? Start with Step 1: Choose Your Tool (5 minutes)**

Generated: 2025-12-24 17:45 GMT+7
