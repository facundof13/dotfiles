[ -f /usr/facebook/ops/rc/master.zshrc ] && source /usr/facebook/ops/rc/master.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ENABLE_CORRECTION="true"
plugins=(git)

setopt inc_append_history
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# cd to the path of the front Finder window
cdf() {
	target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
	if [ "$target" != "" ]; then
		cd "$target"; pwd
	else
		echo 'No Finder window found' >&2
	fi
}

alias lg="lazygit"
alias reloadzsh=". ~/.zshrc"
alias editzsh="code ~/.zshrc"
alias python="python3.9"
alias pip="pip3.9"
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word
funtion dc() {dev connect -y "$1" -h $2.od.fbinfra.net;}

# Load Facebook stuff (don't remove this line).

# Keep oodles of command history (see https://fburl.com/zshhistory).
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD

# Enforce a safer 'sudo rm' for interactive sessions (https://fburl.com/workplace/pbo3xan0)
if [[ -o interactive ]]; then
    sudo() {
        if [ "$1" = "rm" ]; then
            shift
            command sudo rm --preserve-root=all --one-file-system "$@"
        else
            command sudo "$@"
        fi
    }
fi

bindkey "^[[3~" delete-char

pingme () {
  local msg=${1:-ping}
  msg=${msg//\"/\\\\\\\\\"}
  jf graphql --query 'query($m: String!) { pingme(message: $m) }' --variables '{"m": "'"$msg"'"}'
}
source <(fzf --zsh)
eval "$(zoxide init zsh)"
zf() { z "$(dirname "$1")"; }
# zshrc is sourced in interactive shells.  It should contain commands to set up
# aliases, functions, options, key bindings, etc.

# Keep oodles of command history (see https://fburl.com/zshhistory).
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD

# Enforce a safer 'sudo rm' for interactive sessions (https://fburl.com/workplace/pbo3xan0)
if [[ -o interactive ]]; then
    sudo() {
        if [ "$1" = "rm" ]; then
            shift
            command sudo rm --preserve-root=all --one-file-system "$@"
        else
            command sudo "$@"
        fi
    }
fi

bindkey "^[[3~" delete-char

pingme () {
  local msg=${1:-ping}
  msg=${msg//\"/\\\\\\\\\"}
  jf graphql --query 'query($m: String!) { pingme(message: $m) }' --variables '{"m": "'"$msg"'"}'
}
source <(fzf --zsh)
eval "$(zoxide init zsh)"
zf() { z "$(dirname "$1")"; }

alias la="eza --color -lah"

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# Set cursor to vertical line (beam)
echo -ne '\e[6 q'

PS1='%n@%m %~ $ '
alias rg="rg -i"

unalias nvim 2>/dev/null
nvim() {
  if [[ -e /tmp/nvim.sock ]]; then
    command nvim "$@"
  else
    command nvim --listen /tmp/nvim.sock "$@"
  fi
}
export PATH="$HOME/.local/bin:$PATH"

claudefast() {
  META_CLAUDE_CODE_NATIVE_BIN=1 \
  META_CLAUDE_USE_ANTHROPIC_DIRECT=1 \
  META_ANTHROPIC_API_KEY=$(claude-meta inference get-secret OPUS_FAST_API_KEY) \
  claude --dangerously-skip-permissions "$@"
}

# pnpm
export PNPM_HOME="/Users/facundof/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias ll='ls -lhtra'
alias ls='ls -lhtra'
export HUSKY=0

mango() {
  local window_id
  window_id=$(tmux display-message -p '#{window_id}')

  local name="$1"
  if [[ -z "$name" ]]; then
    echo "Usage: mango <worktree-name>"
    return 1
  fi

  local repo_dir="$HOME/Developer/multimango.com"
  local worktree_dir="$HOME/.multimango/worktrees/$name"

  # Ensure we're in tmux
  if [[ -z "$TMUX" ]]; then
    echo "Error: must be inside a tmux session"
    return 1
  fi

  # Run setup-worktree.sh; timeout kills the exec'd shell that lingers after setup
  (cd "$repo_dir" && SHELL=/usr/bin/true ./scripts/setup-worktree.sh "$name")
  local exit_code=$?
  # 124 = timeout killed the exec'd shell, which is expected
  if [[ $exit_code -ne 0 && $exit_code -ne 124 ]]; then
    echo "Error: setup-worktree.sh failed (exit code $exit_code)"
    return 1
  fi

  # Rename the current tmux window
  tmux rename-window -t "$window_id" "$name"

  # Pane 0 (current): run claudefast
  tmux send-keys -t "$window_id" "cd $worktree_dir && claudefast" Enter

  # Split vertically -> pane 1: lazygit
  tmux split-window -h -t "$window_id" -c "$worktree_dir"
  tmux send-keys -t "$window_id" "lg" Enter

  # Split pane 1 horizontally -> pane 2: pnpm dev
  tmux split-window -v -t "$window_id" -c "$worktree_dir"
  tmux send-keys -t "$window_id" "pnpm dev" Enter

  # Focus back on the claudefast pane
  tmux select-pane -t -t "${window_id}.0"
}

e2e() { SKIP_WEBSERVER=1 E2E_PORT=${1:?"Usage: e2e <port> [path]"} pnpm test:e2e ${2:-e2e/mango-eval-studio} }
