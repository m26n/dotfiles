# Initial setup
## Setup bare git repo
```
git init --bare $HOME/.cfg
```
## Add worktree to `.gitignore`
```
echo ".cfg" >> .gitignore
```

# Install on new machine
## Clone repo
```
git clone --bare https://github.com/m26n/dotfiles.git $HOME/.cfg
```

# Add configuration
> **ℹ️ Info**
> 
> Don't be confused by `config config`. The first `config` resolves to the alias, the second `config` is a parameter for `git`.
## ZSH
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
exec zsh
```
## Bash
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
source $HOME/.bashrc
```

## Overwrite existing files such as .zshrc or .bashrc
```
config fetch
config reset --hard main
```

# Handling **remote-only** files, such as README.md and LICENSE
```
echo '/*' > $HOME/.cfg/info/sparse-checkout
echo '!README.md' >> $HOME/.cfg/info/sparse-checkout
echo '!LICENSE' >> $HOME/.cfg/info/sparse-checkout
```
If you want to edit these files locally, use `show_remote_config_file`. This script is defined in `scripts/dotfiles/remote-files.sh`
```
show_remote_config_file README.md 
```
```
show_remote_config_file LICENSE 
```
Make your changes, then commit and push them.
```
config add README.md LICENSE
config commit -m "Update README and LICENSE"
config push
```
Finally, remove them from the local filesystem by using `hide_remote_config_file`. This script is defined in `scripts/dotfiles/remote-files.sh`
```
hide_remote_config_file README.md 
```
```
hide_remote_config_file LICENSE 
```
# Usage
View current status
```
config status
```
Add file to repo
```
config add .zshrc
```
```
config commit -m "add zshrc config"
```
Push to remote
```
config push
```

