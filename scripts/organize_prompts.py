#!/usr/bin/env python3
"""
Organizes visual prompts from ψ/writing/slides into individual files in scripts/prompts/

Handles multiple source formats:
- Consolidated MD files (301-310, 311-320, etc.)
- Individual MD files (321-330, 361-370, etc.)
- Frontmatter-based files (391-400)

Creates standardized files: antigravity-NNN-slug.md
"""

import re
import os
from pathlib import Path
from datetime import datetime

ROOT = "/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
PROMPTS_DIR = f"{ROOT}/scripts/prompts"
SLIDES_DIR = f"{ROOT}/ψ/writing/slides"

# Ensure output directory exists
os.makedirs(PROMPTS_DIR, exist_ok=True)

def slugify(text):
    """Convert title to URL-safe slug"""
    slug = text.lower().strip()
    slug = re.sub(r'[^a-z0-9\s\-]', '', slug)
    slug = re.sub(r'\s+', '-', slug)
    slug = re.sub(r'-+', '-', slug).strip('-')
    return slug

def extract_consolidated(file_path, start_num, end_num):
    """Extract prompts from consolidated markdown file"""
    if not os.path.exists(file_path):
        return {}

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    prompts = {}

    for num in range(start_num, end_num + 1):
        # Try multiple header patterns
        patterns = [
            rf'^##\s+Prompt\s+{num}:\s+([^#\n]+)',  # ## Prompt NNN: Title
            rf'^##\s+{num}:\s+["\']?([^#"\'\n]+)["\']?',  # ## NNN: "Title"
        ]

        match = None
        for pattern in patterns:
            match = re.search(pattern, content, re.MULTILINE)
            if match:
                break

        if not match:
            continue

        title = match.group(1).strip().rstrip(':').strip()

        # Get full section content (from match to next ## or end)
        start_pos = match.start()
        next_section = re.search(r'^##\s', content[match.end():], re.MULTILINE)

        if next_section:
            end_pos = match.end() + next_section.start()
        else:
            end_pos = len(content)

        section_content = content[start_pos:end_pos].strip()

        slug = slugify(title)

        prompts[num] = {
            'title': title,
            'slug': slug,
            'full_content': section_content
        }

    return prompts

def extract_individual_file(file_path):
    """Extract single prompt from individual file (with frontmatter)"""
    if not os.path.exists(file_path):
        return None

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Extract frontmatter
    fm_match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
    if not fm_match:
        return None

    fm_content = fm_match.group(1)
    file_number_match = re.search(r'file_number:\s*(\d+)', fm_content)

    if not file_number_match:
        return None

    file_number = int(file_number_match.group(1))

    # Extract title (# Title format or from filename)
    title_match = re.search(r'^#\s+(.+?)$', content, re.MULTILINE)
    if title_match:
        title = title_match.group(1)
    else:
        # Use filename as fallback
        title = Path(file_path).stem

    slug = slugify(title)

    return {
        'file_number': file_number,
        'title': title,
        'slug': slug,
        'full_content': content
    }

def extract_directory_individual(directory, pattern_prefix):
    """Extract all individual files from directory matching pattern"""
    prompts = {}

    if not os.path.isdir(directory):
        return prompts

    for file_path in sorted(Path(directory).glob(f"{pattern_prefix}-*.md")):
        prompt = extract_individual_file(str(file_path))
        if prompt:
            num = prompt['file_number']
            prompts[num] = prompt

    return prompts

def save_prompt_file(num, title, slug, content):
    """Save individual prompt file"""
    filename = f"antigravity-{num}-{slug}.md"
    filepath = os.path.join(PROMPTS_DIR, filename)

    # Ensure content preserves all data
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

    return filepath

# Define all source files
CONSOLIDATED_SOURCES = [
    ('oracle-philosophy', f"{SLIDES_DIR}/results/visual-prompts-301-310-oracle-philosophy.md", 301, 310),
    ('psi-pillars', f"{SLIDES_DIR}/results/prompts-311-320-psi-pillars.md", 311, 320),
    ('subagent-personas', f"{SLIDES_DIR}/results/prompts-331-340-subagent-personas.md", 331, 340),
    ('command-workflows', f"{SLIDES_DIR}/results/prompts-341-350-command-workflows.md", 341, 350),
    ('learning-patterns', f"{SLIDES_DIR}/results/LEARNING-PATTERNS-prompts-351-360.md", 351, 360),
    ('anti-patterns', f"{SLIDES_DIR}/results/prompts-371-380-anti-patterns.md", 371, 380),
]

INDIVIDUAL_DIR_SOURCES = [
    ('maw-patterns', f"{SLIDES_DIR}/prompts", '3[23]', 321, 330),  # 321-330
]

CONSOLIDATED_FILE_SOURCES = [
    ('energy-rhythm', f"{SLIDES_DIR}/prompts/361-370-energy-rhythm.md", 361, 370),
    ('graduated-projects', f"{SLIDES_DIR}/visual-prompts-graduated-projects.md", 381, 390),
]

OTHER_SOURCES = [
    ('teaching-prompts', f"{SLIDES_DIR}/391-metaphor-over-technical.md", 391, 400),  # Will try individual files
]

# ============================================================================
# PROCESS CONSOLIDATED FILES
# ============================================================================
print("=" * 80)
print("PROCESSING CONSOLIDATED MARKDOWN FILES")
print("=" * 80)

all_created = []
total_prompts = 0

for category, path, start, end in CONSOLIDATED_SOURCES:
    print(f"\n[{category.upper()}] {start}-{end}")
    print(f"  Source: {path}")

    prompts = extract_consolidated(path, start, end)
    print(f"  Extracted: {len(prompts)} prompts")

    if prompts:
        for num in sorted(prompts.keys()):
            p = prompts[num]
            filepath = save_prompt_file(num, p['title'], p['slug'], p['full_content'])
            filename = os.path.basename(filepath)
            all_created.append({
                'num': num,
                'title': p['title'],
                'slug': p['slug'],
                'file': filename
            })
            total_prompts += 1
            print(f"    {num}: {p['title'][:50]:50} → {filename}")

# ============================================================================
# PROCESS INDIVIDUAL FILES IN DIRECTORY
# ============================================================================
print("\n" + "=" * 80)
print("PROCESSING INDIVIDUAL FILES IN DIRECTORY")
print("=" * 80)

for category, directory, pattern, start, end in INDIVIDUAL_DIR_SOURCES:
    print(f"\n[{category.upper()}] {start}-{end}")
    print(f"  Directory: {directory}")
    print(f"  Pattern: {pattern}-*.md")

    prompts = extract_directory_individual(directory, pattern)
    print(f"  Extracted: {len(prompts)} files")

    if prompts:
        for num in sorted(prompts.keys()):
            p = prompts[num]
            filepath = save_prompt_file(num, p['title'], p['slug'], p['full_content'])
            filename = os.path.basename(filepath)
            all_created.append({
                'num': num,
                'title': p['title'],
                'slug': p['slug'],
                'file': filename
            })
            total_prompts += 1
            print(f"    {num}: {p['title'][:50]:50} → {filename}")

# ============================================================================
# PROCESS CONSOLIDATED FILES (continued)
# ============================================================================
print("\n" + "=" * 80)
print("PROCESSING ADDITIONAL CONSOLIDATED FILES")
print("=" * 80)

for category, path, start, end in CONSOLIDATED_FILE_SOURCES:
    print(f"\n[{category.upper()}] {start}-{end}")
    print(f"  Source: {path}")

    prompts = extract_consolidated(path, start, end)
    print(f"  Extracted: {len(prompts)} prompts")

    if prompts:
        for num in sorted(prompts.keys()):
            p = prompts[num]
            filepath = save_prompt_file(num, p['title'], p['slug'], p['full_content'])
            filename = os.path.basename(filepath)
            all_created.append({
                'num': num,
                'title': p['title'],
                'slug': p['slug'],
                'file': filename
            })
            total_prompts += 1
            print(f"    {num}: {p['title'][:50]:50} → {filename}")

# ============================================================================
# PROCESS REMAINING SOURCES (391-400)
# ============================================================================
print("\n" + "=" * 80)
print("PROCESSING REMAINING SOURCES (391-400)")
print("=" * 80)

# Try as consolidated file
path = f"{SLIDES_DIR}/TEACHING_PROMPTS_391-400.md"
print(f"\n[TEACHING_PROMPTS] 391-400")
print(f"  Trying: {path}")

if os.path.exists(path):
    prompts = extract_consolidated(path, 391, 400)
    print(f"  Extracted: {len(prompts)} prompts")

    if prompts:
        for num in sorted(prompts.keys()):
            p = prompts[num]
            filepath = save_prompt_file(num, p['title'], p['slug'], p['full_content'])
            filename = os.path.basename(filepath)
            all_created.append({
                'num': num,
                'title': p['title'],
                'slug': p['slug'],
                'file': filename
            })
            total_prompts += 1
            print(f"    {num}: {p['title'][:50]:50} → {filename}")
else:
    # Try individual files
    print(f"  File not found, trying individual files...")
    prompts = extract_directory_individual(f"{SLIDES_DIR}", '39[1-9]')
    if not prompts:
        prompts = extract_directory_individual(f"{SLIDES_DIR}", '400')

    print(f"  Extracted: {len(prompts)} files")
    if prompts:
        for num in sorted(prompts.keys()):
            p = prompts[num]
            filepath = save_prompt_file(num, p['title'], p['slug'], p['full_content'])
            filename = os.path.basename(filepath)
            all_created.append({
                'num': num,
                'title': p['title'],
                'slug': p['slug'],
                'file': filename
            })
            total_prompts += 1
            print(f"    {num}: {p['title'][:50]:50} → {filename}")

# ============================================================================
# SUMMARY
# ============================================================================
print("\n" + "=" * 80)
print("SUMMARY")
print("=" * 80)
print(f"\nTotal prompts created: {total_prompts}")
print(f"Output directory: {PROMPTS_DIR}")

if all_created:
    # Group by hundreds
    by_hundred = {}
    for item in all_created:
        hundred = (item['num'] // 100) * 100
        if hundred not in by_hundred:
            by_hundred[hundred] = []
        by_hundred[hundred].append(item)

    for hundred in sorted(by_hundred.keys()):
        items = by_hundred[hundred]
        nums = [str(item['num']) for item in items]
        print(f"  {hundred}-{hundred+99}: {len(items)} files ({', '.join(nums[:3])}{'...' if len(nums) > 3 else ''})")

print("\nDone!")
