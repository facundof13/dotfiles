# halp — Ctrl+G to replace command line text with an LLM-suggested shell command
__halp_replace() {
    local query="$BUFFER"
    if [[ -z "$query" ]]; then
        return
    fi
    # Show thinking indicator
    zle -R "# thinking..."
    # Query ttymate for a shell command
    local result
    result=$(ttymate -q shell "$query" 2>/dev/null)
    if [[ $? -ne 0 || -z "$result" ]]; then
        # On error, restore original text and redisplay
        zle redisplay
        return
    fi
    # Replace command line with the result
    BUFFER="$result"
    CURSOR=${#BUFFER}
    zle redisplay
}
zle -N __halp_replace
bindkey '^G' __halp_replace

