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
```
git clone --bare https://github.com/m26n/dotfiles.git $HOME/.cfg
```

# Add configuration
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

# Optional configuration
## Only keep README.md and LICENSE file in remote
Execute these commands after initial checkout to remove these files from local system **only**.
```
config rm --cached README.md LICENSE
rm $HOME/README.md $HOME/LICENSE
echo 'README.md' >> $HOME/.cfg/info/exclude
echo 'LICENSE' >> $HOME/.cfg/info/exclude
```
If you want to edit these files locally, use `git show` with `config show`. This will make the files visible in your worktree.
```
config show README.md > $HOME/README.md
config show LICENSE > $HOME/LICENSE
```
Make your changes, then commit and push them.
```
config add README.md LICENSE
config commit -m "Update README and LICENSE"
config push
```
Finally, remove them from the local filesystem.
```
rm $HOME/README.md $HOME/LICENSE
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
