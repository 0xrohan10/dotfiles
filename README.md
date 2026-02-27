# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package  | Contents |
|----------|----------|
| `zsh`    | `.zshrc`, `.zsh_aliases`, `.zsh_plugins.txt`, `.zprofile`, `.zshenv`, `.zfunc/` |
| `git`    | `.gitconfig`, `.gitignore_global`, `.gitattributes`, `.tool-versions` |
| `tmux`   | `.tmux.conf` |
| `config` | `starship.toml`, `nushell/`, `karabiner/`, `gh/`, `zed/` (via `.config/`) |
| `claude` | `CLAUDE.md`, `settings.json`, hooks, skills (via `.claude/`) |

## Install on a new machine

```bash
bash <(curl -s https://raw.githubusercontent.com/0xrohan10/dotfiles/main/bootstrap.sh)
```

Or manually:

```bash
brew install stow
git clone git@github.com:0xrohan10/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --adopt zsh git tmux config claude
git restore .
```

`--adopt` moves any pre-existing files into the stow directory, then `git restore .` resets them to the repo version.

## Adding new files

```bash
# Move the file into the appropriate package
mv ~/.newconfig ~/dotfiles/zsh/.newconfig

# Re-stow the package
cd ~/dotfiles && stow zsh
```
