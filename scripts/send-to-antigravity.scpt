-- Send prompt to Antigravity sidebar chat
-- Usage: osascript send-to-antigravity.scpt "your prompt here"

on run argv
    set promptText to item 1 of argv

    -- Set clipboard to prompt
    set the clipboard to promptText

    -- Activate Antigravity app
    tell application "Antigravity"
        activate
    end tell

    delay 0.5

    tell application "System Events"
        tell process "Antigravity"
            set frontmost to true
            delay 0.3

            -- Get window size to click middle screen
            set winPos to position of window 1
            set winSize to size of window 1
            set winX to item 1 of winPos
            set winY to item 2 of winPos
            set winW to item 1 of winSize
            set winH to item 2 of winSize

            -- Click middle of screen to activate (convert to integer)
            set clickX to winX + (winW / 2) as integer
            set clickY to winY + (winH / 2) as integer

        end tell
    end tell

    -- Click middle screen to activate Antigravity
    do shell script "cliclick c:" & clickX & "," & clickY

    delay 0.5

    tell application "System Events"
        -- Cmd+L to move cursor to AI chat box (sidebar)
        keystroke "l" using command down
        delay 1.0

        -- Now paste in the chat input
        keystroke "v" using command down
        delay 0.3
        -- Send
        keystroke return
    end tell

    return "Sent to Antigravity: " & promptText
end run
