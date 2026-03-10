# MAW hey.sh: Buffer Method for Multiline Content

**Date**: 2025-12-20

## What We Learned

- `tmux send-keys` struggles with multiline content from `$(cat file)`
- Long pasted text (49+ lines) doesn't submit reliably
- Solution: Use `tmux load-buffer` + `paste-buffer` for multiline

### The Fix

```bash
# In hey.sh send_message()
if [[ "$text" == *$'\n'* ]] || [[ ${#text} -gt 500 ]]; then
    # Buffer method for multiline/long content
    echo "$text" | tmux load-buffer -
    tmux paste-buffer -t "$pane"
    sleep 0.1
    tmux send-keys -t "$pane" Enter
else
    # Simple send for short single-line
    tmux send-keys -t "$pane" "$text"
    sleep 0.05
    tmux send-keys -t "$pane" Enter
fi
```

## Key Insights

1. **Condition**: Check for newlines OR length > 500 chars
2. **Buffer path**: `echo | load-buffer` → `paste-buffer` → `Enter`
3. **Slight delay**: 0.1s instead of 0.05s for buffer method

## How Things Connect

- **MAW parallel work** needs to send task files (40-60 lines) via `maw hey`
- **Task templates** in `ψ/lab/maw-demo/tasks/` are multiline markdown
- **Workflow**: `maw hey 1 "$(cat task.md)"` now works reliably

## When to Use

- Sending long prompts to agents via `maw hey`
- Any multiline content to tmux panes
- Task files, code snippets, multi-paragraph instructions

## Tags

`maw` `tmux` `hey.sh` `multiline` `buffer` `fix`
