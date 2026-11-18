# Personal Configs

Development configs managed with symlinks. Run setup from this repo's root;
back up existing targets before linking.

## Config links

### macOS / Linux

```sh
repo="$PWD"
mkdir -p ~/.config/mise ~/.config/herdr
ln -sfn "$repo/shell/.zshrc" ~/.zshrc
ln -sfn "$repo/starship/starship.toml" ~/.config/starship.toml
ln -sfn "$repo/mise/config.toml" ~/.config/mise/config.toml
ln -sfn "$repo/herdr/config.toml" ~/.config/herdr/config.toml
```

### Windows (Git Bash)

```sh
repo="$PWD"
mkdir -p ~/.config/mise
ln -sfn "$repo/shell/windows.bashrc" ~/.bashrc
ln -sfn "$repo/starship/starship.toml" ~/.config/starship.toml
ln -sfn "$repo/mise/config.toml" ~/.config/mise/config.toml
```

Windows symlinks require Developer Mode or elevated permissions. Open a new
shell after linking.

## Coding sandbox (Apple Silicon, Lima 2.3+)

### Create once — Mac

```sh
brew install lima
limactl validate sandbox/omp/lima.yaml
limactl start --tty=false --name=omp sandbox/omp/lima.yaml
```

This is an instance template, not a global Lima default/override. Global
settings can weaken isolation. Lima copies the template at creation: source
edits require recreating the VM **after backing up work**. Do not symlink over
the generated `~/.lima/omp/lima.yaml`.

### Daily session — Mac

```sh
limactl start omp
limactl shell --preserve-env=false --workdir=/tmp omp sudo -iu agent
```

### Install and work — agent shell

```sh
curl -fsSL https://omp.sh/install -o ~/omp-install.sh
less ~/omp-install.sh                    # inspect before running
sh ~/omp-install.sh --binary             # pin with --ref vVERSION
omp --version
cd ~/work
# Clone your repository here using its HTTPS URL.
tmux new-session -A -s coding
omp
```

In omp: `/login openai-codex-device`, then `/model`. Complete login in your Mac's
browser. Claude subscriptions use Claude Code; Anthropic API access in omp is
billed separately.

Keep projects in `~/work`. Review with `git diff`; commit and push a branch.
Use scoped guest credentials, never personal SSH private keys. Detach tmux with
**Ctrl+B, D**; it survives terminal disconnects, not VM shutdown.

### OS maintenance — separate Mac terminal

```sh
limactl shell --preserve-env=false --workdir=/tmp omp
# Now in the sudo-capable management shell:
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install libpq-dev           # example system dependency
sudo nft list ruleset                   # inspect policy and reject counters
exit
```

**Never run omp or project scripts as the management user.** Install user-local
tools as `agent`; use management only for reviewed OS operations. Security
updates are automatic; reboots are not.

### Preview a guest web server — Mac

With the server running on guest `127.0.0.1:3000`:

```sh
ssh_config="$(limactl list --format='{{.SSHConfigFile}}' omp)"
ssh -F "$ssh_config" -o ExitOnForwardFailure=yes \
  -N -L 127.0.0.1:3000:127.0.0.1:3000 lima-omp
```

Open `http://127.0.0.1:3000` on your Mac. Ctrl+C closes the tunnel.

### Stop — Mac

```sh
limactl stop omp                         # save work first
```

### Security limits

- No host mounts, SSH-agent forwarding, or automatic application-port exposure.
  Do not bypass this with host-connected MCP/browser relays or preserved host env.
- Root-owned firewall blocks listed non-public IPv4 ranges and external IPv6.
  Public TCP 80/443, DNS, NTP, and necessary virtual DHCP/DNS are allowed.
  Use Git over HTTPS; outbound SSH is blocked.
- Publicly addressed IPv4 LANs need their ranges added to `non_public_v4`.
  VPN DNS and mandatory proxies may not work.
- Public web/DNS access permits exfiltration. All projects and credentials under
  `agent` share one trust level; use another VM for untrusted repositories.
- Guest-root/kernel compromise defeats guest firewall enforcement. Keep FileVault
  enabled and back up work; VM disks and backups contain credentials.
