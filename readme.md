# .Dotfiles syncing

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

- install oh-my-zsh
```bash
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

Symlink directories
```bash
mv ~/.zsrhc ~/.zshrc.old
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

