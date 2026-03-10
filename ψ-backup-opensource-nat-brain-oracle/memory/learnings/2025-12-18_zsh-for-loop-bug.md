# Zsh For Loop Bug: $() Before For

**Date**: 2025-12-18

## The Bug

Zsh fails to parse `for` loops when `$(...)` command substitution appears directly before them in the same command block.

```bash
# ❌ FAILS - parse error near 'do'
echo "🕐 $(date)" && for i in 1 2; do echo $i; done

# ❌ FAILS - same issue
echo "Time: $(date '+%H:%M')"
for i in 1 2 3; do
  echo "Item $i"
done
```

## The Fix

Assign command substitution to a variable first:

```bash
# ✅ WORKS
date_str=$(date '+%H:%M')
echo "🕐 $date_str"
for i in 1 2 3; do
  echo "Item $i"
done
```

## Prevention Rule

> **Never put `$(...)` directly before a `for` loop in the same command block.**

1. Assign to variable first
2. Use the variable in echo
3. Then run for loop

## Why This Happens

Zsh parser gets confused when `$(...)` and `for...do...done` are in the same evaluation context. Separating them into distinct statements fixes the parsing order.

## Tags

`zsh` `bash` `bug` `for-loop` `shell`
