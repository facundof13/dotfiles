# .Dotfiles syncing

## Homebrew

- install homebrew from [official site](https://brew.sh/)

## iTerm2

- clone repo

```bash
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true</code>
```

## zsh

- install zsh

```bash
brew install zsh
```

- install oh-my-zsh and powerlevel10k

```bash
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Symlink directories

```bash
mv ~/.zsrhc ~/.zshrc.old
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

## neovim

- install neovim

```bash
brew install neovim
```

Symlink directories

```bash
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

## tmux

- install tmux

```bash
brew install tmux
```

- Symlink directories
