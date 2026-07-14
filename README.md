# 💤 lazyvim-config

My personal [LazyVim](https://github.com/LazyVim/LazyVim) Neovim configuration, version-controlled so it reproduces on any machine. Plugin versions are pinned in `lazy-lock.json`, so a fresh clone installs the exact same set everywhere.

## What's inside

Standard LazyVim starter layout (`init.lua` → `lua/config/*` → `lua/plugins/*`).

**Enabled LazyVim extras** (see `lazyvim.json`): AI (Claude Code), Telescope, DAP, testing, and language support for C/C++ (clangd), CMake, Python, TypeScript, JSON, Markdown, Ansible and Git — plus util extras (gh, gitui, mini-hipatterns) and coding extras (mini-surround, yanky).

**Custom tweaks** under `lua/plugins/`:

| File | What it does |
|---|---|
| `ansi.lua` | Auto-colorize ANSI escape codes in `*.log` / `*.ansi` files (baleia.nvim) + `:BaleiaColorize` on demand |
| `cmp-tab.lua` | `<Tab>` / `<S-Tab>` completion navigation for blink.cmp (super-tab preset) |
| `snacks.lua` + `neo-tree.lua` | snacks explorer docked on the right; open files without leaving the explorer |
| `persistence.lua` | Session save/restore — `<leader>qs` (cwd), `<leader>ql` (last), `<leader>qd` (disable) |
| `scope.lua` | Per-tab buffer scoping (scope.nvim) |

Plus `lua/config/options.lua` enables `undofile`, and `lua/config/autocmds.lua` auto-saves the buffer on `InsertLeave` / `TextChanged` / `FocusLost`.

## Requirements

Neovim must be **≥ 0.11.2** (a LuaJIT build). The **Core** tools are needed for the config to work well; the **Optional** tools are only needed for the languages/features you actually use.

### Core

| Tool | Why it's needed |
|---|---|
| Neovim ≥ 0.11.2 (LuaJIT) | The editor; older versions error on startup |
| git ≥ 2.19 | lazy.nvim clones plugins with filtered/partial clones |
| C compiler + make | nvim-treesitter compiles parsers from source |
| curl, unzip | Mason downloads & extracts language servers/tools |
| ripgrep (`rg`) | Live-grep / project-wide text search |
| fd | Fast file finding in Telescope & snacks pickers |
| A Nerd Font | UI glyphs/icons (set it as your **terminal** font) |
| lazygit | Git UI, opened with `<leader>gg` |

Quick install of the core set:

```bash
# Debian / Ubuntu / WSL
sudo apt install git build-essential curl unzip ripgrep fd-find
# On Debian, fd's binary is 'fdfind' — expose it as 'fd' so the pickers find it:
mkdir -p ~/.local/bin && ln -s "$(command -v fdfind)" ~/.local/bin/fd
# Neovim: apt is usually older than 0.11.2 — install the AppImage/tarball from
#   https://github.com/neovim/neovim/releases  (or use the 'bob' version manager)
# lazygit: grab the release binary from
#   https://github.com/jesseduffield/lazygit/releases
```

```bash
# macOS (Homebrew)
xcode-select --install                       # C compiler + make
brew install neovim git ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font
```

```bash
# Arch
sudo pacman -S neovim git base-devel curl unzip ripgrep fd lazygit ttf-jetbrains-mono-nerd-font
```

> **Nerd Font is a terminal setting, not something Neovim installs.** Install a Nerd Font (e.g. JetBrainsMono) on the host and select it as your terminal emulator's font. Under WSL, set the font in Windows Terminal / VS Code — not inside Linux.

### Optional (per language / extra)

Mason installs the language servers, linters and formatters, but it does **not** install their runtimes. Install the runtime **first**, then run `:Mason` / `:LazyExtras`.

| For | Tool to install |
|---|---|
| TypeScript / JSON / Markdown / Ansible language servers | Node.js + npm |
| Python (ruff, debugpy, pytest), cmakelang, ansible-lint | Python 3 + pip + venv |
| C/C++ (`lang.clangd`) | clangd + a C/C++ toolchain |
| CMake (`lang.cmake`) | cmake |
| Ansible (`lang.ansible`) | ansible + ansible-lint |
| GitHub PRs/issues (`util.gh`) | gh (GitHub CLI) |
| gitui (`util.gitui`) | gitui |
| Claude Code (`ai.claudecode`) | `claude` CLI on PATH (implies Node.js) |
| System clipboard on Linux/WSL (`coding.yanky`) | wl-clipboard / xclip / win32yank |

<details>
<summary>Per-OS install commands for the optional tools</summary>

```bash
# --- Node.js + npm ---
apt:    sudo apt install nodejs npm        # or use nvm/fnm for a current LTS
brew:   brew install node
pacman: sudo pacman -S nodejs npm

# --- Python 3 + pip + venv ---
apt:    sudo apt install python3 python3-pip python3-venv
brew:   brew install python
pacman: sudo pacman -S python python-pip

# --- clangd (C/C++) ---
apt:    sudo apt install clangd            # or: clang-tools
brew:   brew install llvm                  # clangd ships inside LLVM
pacman: sudo pacman -S clang

# --- cmake ---
apt:    sudo apt install cmake
brew:   brew install cmake
pacman: sudo pacman -S cmake

# --- ansible + ansible-lint ---
apt:    sudo apt install ansible ansible-lint
brew:   brew install ansible ansible-lint
pacman: sudo pacman -S ansible ansible-lint

# --- gh (GitHub CLI) ---
apt:    sudo apt install gh                # older releases: add GitHub's apt repo per cli.github.com
brew:   brew install gh
pacman: sudo pacman -S github-cli

# --- gitui ---
apt:    cargo install gitui                # or a release binary from github.com/gitui-org/gitui
brew:   brew install gitui
pacman: sudo pacman -S gitui

# --- Claude Code CLI ---
any:    npm install -g @anthropic-ai/claude-code   # verify current install at docs.claude.com

# --- Clipboard provider (Linux/WSL only; macOS is built in) ---
Wayland/WSLg: sudo apt install wl-clipboard   (Arch: sudo pacman -S wl-clipboard)
X11:          sudo apt install xclip
classic WSL:  install win32yank.exe from github.com/equalsraf/win32yank, put it on PATH
```

`dap.core` (nvim-dap) also needs per-language debug adapters (e.g. `debugpy` for Python, `codelldb` for C/C++) and `test.core` (neotest) needs per-language runners (e.g. `pytest`) — these are installed via Mason/pip once the runtime is present.

</details>

## Install on a new computer

This is a **LazyVim** config, so setup is the standard [LazyVim installation](https://lazyvim.github.io/installation) with this repo standing in for the LazyVim starter. You do **not** clone the LazyVim starter separately — cloning this repo and launching Neovim bootstraps `lazy.nvim`, which then installs LazyVim itself and every plugin at the versions pinned in `lazy-lock.json`. This repo **is** the config; `~/.config/nvim` is just a symlink pointing at it.

**1. Install the prerequisites** — Neovim **≥ 0.11.2** and the [Core tools](#core) (git, a C compiler, ripgrep, fd, a Nerd Font, lazygit). Nothing below works until these are on the machine; see [Requirements](#requirements) for per-OS commands.

**2. Clear any existing Neovim files** — LazyVim expects a clean state on first run. Back up the four Neovim directories if they exist (safe to skip on a brand-new machine that has never run Neovim):

```bash
mv ~/.config/nvim{,.bak}        2>/dev/null   # config
mv ~/.local/share/nvim{,.bak}   2>/dev/null   # plugins & data
mv ~/.local/state/nvim{,.bak}   2>/dev/null   # sessions, undo, shada
mv ~/.cache/nvim{,.bak}         2>/dev/null   # cache
```

**3. Clone this config and symlink it into place** (this replaces LazyVim's "clone the starter" step):

```bash
# SSH shown; use the https URL if you don't have SSH keys on this machine
git clone git@github.com:K0iNguyen/lazyvim-config.git ~/nvim-config
#   https alternative:
#   git clone https://github.com/K0iNguyen/lazyvim-config.git ~/nvim-config

mkdir -p ~/.config
ln -s ~/nvim-config ~/.config/nvim
```

**4. Launch Neovim** — `lazy.nvim` bootstraps itself, installs LazyVim and every plugin, then reads `lazy-lock.json` so you get the exact versions from this repo:

```bash
nvim
```

Once syncing finishes:

- `:checkhealth` — confirm the Neovim version and that ripgrep / fd / node / etc. are detected
- `:Mason` — install/verify language servers for the languages you use
- `:LazyExtras` — view or toggle the enabled extras

## Local (machine-specific) overrides

Project- or machine-specific tweaks are **not** committed, so they don't propagate to your other computers. `lua/plugins/clangd.lua` (an embedded C/C++ / ESP32 clangd override tied to one machine) is `.gitignore`d for exactly this reason — it stays local.

To add your own machine-only override on any computer: drop a spec file under `lua/plugins/` and add its path to `.gitignore`. `lazy.nvim` still loads it locally, but git ignores it so it never gets committed or pushed.

## Syncing your changes

Because `~/.config/nvim` is a symlink into this repo, edits you make from inside Neovim change the repo directly:

```bash
cd ~/nvim-config
git add -A && git commit -m "tweak: ..." && git push
```

After updating plugins (`:Lazy update`), commit the changed `lazy-lock.json` too so other machines stay in sync. On another machine, `git pull` then `:Lazy restore` to snap plugins back to the pinned versions.

## Restoring the original (this machine)

The pre-export config was backed up to `~/.config/nvim.bak-export`. Once you've confirmed Neovim works through the symlink, you can remove it:

```bash
rm -rf ~/.config/nvim.bak-export
```
