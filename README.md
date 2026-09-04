# Personal Configs

Cross-platform development configuration files managed with symlinks.

## Setup

Run the commands from the repository root. Back up any existing target files
before creating the links.

### Linux and macOS

```sh
repo="$(pwd)"

mkdir -p "$HOME/.config/mise" "$HOME/.config/herdr"

ln -sfn "$repo/shell/.zshrc" "$HOME/.zshrc"
ln -sfn "$repo/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sfn "$repo/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -sfn "$repo/herdr/config.toml" "$HOME/.config/herdr/config.toml"
```

### Windows (Git Bash)

```sh
repo="$(pwd)"

mkdir -p "$HOME/.config/mise"

ln -sfn "$repo/shell/windows.bashrc" "$HOME/.bashrc"
ln -sfn "$repo/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sfn "$repo/mise/config.toml" "$HOME/.config/mise/config.toml"
```

On native Windows, enable Developer Mode or run the shell with sufficient
permissions to create symlinks. The shell configuration currently targets
Bash and zsh

Start a new shell after linking the files. Verify a link with:

```sh
ls -l "$HOME/.config/starship.toml"
```
