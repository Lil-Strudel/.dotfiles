<p align="center">
  <img src="/.github/assets/banner.svg" alt="A Kanagawa-coloured Hyprland desktop: waybar, a zsh terminal, Neovim and a tmux pane running workmux and Claude Code" width="100%">
</p>

<h1 align="center">Lil Strudel's .dotfiles</h1>

<p align="center">
  A minimal, hand-rolled Arch + Hyprland setup where every line had to earn its place.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-181616?style=flat-square&logo=archlinux&logoColor=8ba4b0" alt="Arch Linux">
  <img src="https://img.shields.io/badge/Hyprland-181616?style=flat-square&logo=hyprland&logoColor=8ea4a2" alt="Hyprland">
  <img src="https://img.shields.io/badge/Neovim-181616?style=flat-square&logo=neovim&logoColor=87a987" alt="Neovim">
  <img src="https://img.shields.io/badge/Kanagawa-Dragon-c4b28a?style=flat-square&labelColor=181616" alt="Kanagawa Dragon">
  <img src="https://img.shields.io/badge/Made_with-love-c4746e?style=flat-square&labelColor=181616" alt="Made with love">
</p>

---

This repo is my whole Linux machine: the packages, the desktop, the terminal, the editor and the notes on how I installed it all. It is also the guide I hand to friends when I convert them to Linux, so it explains **why** each choice was made and **what you could pick instead**.

The rules I built it by:

- **Minimal.** No plugin managers or frameworks where a few lines of config will do. tmux has zero plugins, zsh has two, Neovim has twelve.
- **Questioned.** Every setting was kept only after asking what it does and what breaks without it.
- **No comments in config files.** Good names and small files instead. See [Rob Pike](https://doc.cat-v.org/bell_labs/pikestyle) and [Jeff Atwood](https://blog.codinghorror.com/coding-without-comments/).
- **Fast.** zsh starts in about 40 ms. The prompt costs about 3 ms.
- **Declarative.** Every installed package is listed in a file, and nothing else is installed.

<p align="center">
  <img src="/.github/assets/stack.svg" alt="The stack, top to bottom: zsh, Neovim and Claude Code; tmux; Ghostty; Hyprland; metapac; Arch Linux. yadm tracks the config for every layer." width="100%">
</p>

## Contents

- [Quick start](#quick-start)
- [The full install, step by step](#the-full-install-step-by-step)
- [A tour of the config](#a-tour-of-the-config)
- [Keybindings](#keybindings)
- [Making it yours](#making-it-yours)
- [Day to day](#day-to-day)
- [Known issues](#known-issues)
- [Windows side (dual boot)](#windows-side-dual-boot)

## Quick start

This assumes Arch is already installed with a user that has sudo. If not, start with [the full install](#the-full-install-step-by-step).

```sh
sudo pacman -S yadm
yadm clone --no-bootstrap https://github.com/Lil-Strudel/.dotfiles.git
```

Packages are picked per hostname, so add yours to the `[hostname_groups]` table in `~/.config/metapac/config.toml` and keep the groups you want (drop `nvidia` and `amd` if they don't match your hardware):

```toml
[hostname_groups]
your-hostname = [
    "base", "audio", "desktop", "fonts", "git",
    "zsh", "tmux", "nvim", "languages", "claude", "apps",
]
```

Then let the bootstrap script do the rest:

```sh
yadm bootstrap
```

<details>
<summary><b>What does <code>yadm bootstrap</code> do?</b></summary>

<br>

[`~/.config/yadm/bootstrap`](/.config/yadm/bootstrap) is a short shell script, and running it twice is safe. It:

1. Stops if your hostname isn't in `config.toml` yet.
2. Installs [yay](https://github.com/Jguer/yay) from the AUR if it's missing.
3. Installs [metapac](https://github.com/ripytide/metapac), then runs `metapac sync` to install every package in your groups.
4. Changes your login shell to zsh.
5. Installs the workmux plugin for Claude Code.

Some things it deliberately doesn't do because they're personal or touch the bootloader: SSH keys, fonts, Secure Boot and mirrors. They're covered below.

</details>

Log out and back in on tty1 and Hyprland starts. Press <kbd>Super</kbd> + <kbd>Return</kbd> for a terminal.

> [!NOTE]
> If you are me, `strudel-linux` is already listed, so a plain `yadm clone` will offer to run the bootstrap for you. Afterwards, switch the remote to SSH: `yadm remote set-url origin git@github.com:Lil-Strudel/.dotfiles.git`.

## The full install, step by step

My machine is a desktop that dual boots Windows 11 (for Valorant, which won't run on Linux) and Arch. Skip the Windows parts if you don't need them.

### 1. Plan the disk

I partition before installing anything, from an Ubuntu live USB with GParted. GParted makes sizing partitions far easier than the Arch installer or the Windows installer.

| # | Size | Filesystem | Flags | Purpose |
|---|---|---|---|---|
| 1 | 1 GiB | FAT32 | `esp`, `boot` | EFI partition, shared by Windows and Linux. Mounted at `/boot` on Arch |
| 2 | 16 MiB | none | `msftres` | Microsoft reserved partition |
| 3 | half of the rest | NTFS | `msftdata` | Windows |
| 4 | the rest | left unallocated | | Arch fills this during install |

<details>
<summary><b>Decisions and your options</b></summary>

<br>

- **One shared 1 GiB EFI partition.** systemd-boot and the kernel images live on it, and 1 GiB leaves room for several kernels. Windows' default 100 MB is too small. If you aren't dual booting, keep the 1 GiB EFI partition and give Arch everything else.
- **No swap partition.** I don't hibernate and have plenty of RAM. If you have little RAM, turn on zram in archinstall instead.
- **Games go on a second SSD**, formatted NTFS from Windows. Arch doesn't mount it.
- **Install Windows first.** Its installer is happy to use the partition you made, and installing Linux second means its boot menu ends up in charge.

</details>

### 2. Install Windows (if dual booting)

My [answer file](#windows-side-dual-boot) installs Windows unattended and already handles these. If you install by hand, the settings that matter for dual booting are:

- **Fast Startup and hibernation off.** Otherwise Windows leaves the NTFS drives half-mounted and the shared EFI partition can get corrupted.
- **Hardware clock in UTC** so the time doesn't jump when you switch OSes:
  ```powershell
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f
  ```

### 3. Install Arch with archinstall

Boot the Arch ISO (I keep it on a [Ventoy](https://www.ventoy.net) USB), connect to Wi-Fi with `iwctl`, check you're online with `ping archlinux.org`, then run `archinstall`.

| Setting | My choice | Why, and what else you could pick |
|---|---|---|
| Mirrors | none | reflector takes over after install ([step 7](#7-fast-mirrors-that-stay-fast)) |
| Disk | manual | Put `/` (ext4) in the free space, and mount the **existing** EFI partition at `/boot` **without formatting it**. Formatting it would delete Windows' bootloader |
| Encryption | LUKS on `/` | A stolen drive is just noise. You type the password once at boot. On a laptop, always encrypt |
| Swap | zram off | Plenty of RAM, no hibernation. Turn it on with 16 GB of RAM or less |
| Bootloader | systemd-boot | Simpler than GRUB and easy to sign for Secure Boot. GRUB plus `os-prober` works too; the [legacy README](https://github.com/Lil-Strudel/.dotfiles/tree/legacy) covers it |
| Unified kernel image | yes | The kernel, initramfs and cmdline become one `.efi` file, so there's one file to sign |
| Kernel | `linux` | `linux-lts` if you want fewer surprises |
| Profile | **minimal** | Hyprland and everything else comes from metapac. No display manager either |
| Audio | pipewire | The modern default |
| Network | NetworkManager, **default backend** | The iwd backend broke my Wi-Fi card. Stick with wpa_supplicant |
| Firewall | ufw | Deny incoming, allow outgoing. Nothing listens on a desktop |
| Bluetooth | off | Desktop with wired everything. Turn it on for laptops |
| Extra packages | `git base-devel vim` | Enough to build yay and edit files before the dotfiles land |
| Root password | none | Use sudo. With no root password, nobody can log in as root |

### 4. First boot

Turn off `-debug` packages, which only waste disk and build time for AUR packages. In `/etc/makepkg.conf`, change `debug` to `!debug` in `OPTIONS`.

Then follow the [quick start](#quick-start): install yadm, clone, add your hostname, run `yadm bootstrap`.

<details>
<summary><b>Why yay-bin and not paru?</b></summary>

<br>

`paru-bin` is a prebuilt binary linked against a specific `libalpm`. When pacman updated, it broke with a `libalpm.so.15` error. `yay-bin` hasn't had that problem. If you'd rather build from source, `yay` and `paru` both work. Set `package_manager` in `~/.config/metapac/config.toml` to match.

</details>

### 5. Graphics

On NVIDIA, Hyprland won't start until the driver is installed. The `nvidia` group installs `nvidia-open` (for Turing / RTX 20-series and newer). Nothing else is needed: no env vars, no modprobe options, no initramfs edits. Current drivers turn on modesetting by default.

| GPU | Group |
|---|---|
| NVIDIA RTX 20-series or newer | `nvidia` (`nvidia-open`) |
| AMD or Intel | nothing extra, mesa is pulled in by Hyprland |

Do the same for CPU microcode: `amd` has `amd-ucode`. Create an `intel.toml` with `intel-ucode` on Intel.

### 6. Secure Boot with sbctl

Optional, but Valorant's anti-cheat on the Windows side requires Secure Boot. The trick is to enroll your own keys **and** keep Microsoft's.

1. In the BIOS, **clear the Secure Boot keys** (this puts it in Setup Mode), then boot Arch.
2. Create and enroll keys, then sign the bootloader and kernel image:
   ```sh
   sudo sbctl create-keys
   sudo sbctl enroll-keys -m -f
   sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
   sudo sbctl sign -s /boot/EFI/Linux/arch-linux.efi
   sudo bootctl install
   ```
   - `-m` keeps Microsoft's keys. Without it Windows, Vanguard and some GPU firmware won't boot.
   - `-f` keeps your motherboard maker's keys.
   - `-s` records each file so sbctl's pacman hook re-signs it after every update.
3. Reboot, **turn Secure Boot on** in the BIOS, and check with `sudo sbctl verify`.

There's no fallback image to sign: Arch's mkinitcpio preset only builds `default` unless you add `fallback` to `PRESETS`.

<details>
<summary><b>The boot menu doesn't show up?</b></summary>

<br>

A timeout saved in an EFI variable can override `loader.conf`. Clear it, then set the timeout in `/boot/loader/loader.conf` (`timeout 10`):

```sh
sudo bootctl set-timeout ""
sudo bootctl set-timeout-oneshot ""
```

</details>

### 7. Fast mirrors that stay fast

reflector is installed by the `base` group, and metapac enables `reflector.timer` the first time it installs it. You only have to set the options. The timer reads them from `/etc/xdg/reflector/reflector.conf`, **not** from the command line:

```
--country US
--protocol https
--completion-percent 100
--age 6
--delay 1
--fastest 5
--threads 8
--sort rate
--connection-timeout 3
--download-timeout 5
--save /etc/pacman.d/mirrorlist
```

The timer runs weekly by default. To run it daily, use `sudo systemctl edit reflector.timer`:

```ini
[Timer]
OnCalendar=
OnCalendar=daily
```

Run it once by hand with `sudo systemctl start reflector`. Change `--country` to yours.

### 8. SSH keys and signed commits

I use three ed25519 keys: one per Git host for logging in, and one only for signing commits.

```sh
ssh-keygen -t ed25519 -N "" -C "$(hostname) github"  -f ~/.ssh/id_github
ssh-keygen -t ed25519 -N "" -C "$(hostname) gitlab"  -f ~/.ssh/id_gitlab
ssh-keygen -t ed25519 -N "" -C "$(hostname) signing" -f ~/.ssh/id_signing
```

Tell SSH which key goes where in `~/.ssh/config` (not tracked in this repo, since it points at your keys):

```
Host github.com
    IdentityFile ~/.ssh/id_github

Host gitlab.com
    IdentityFile ~/.ssh/id_gitlab
```

Upload them. GitHub, through `gh`:

```sh
gh auth login -h github.com -p ssh --skip-ssh-key -w -s admin:public_key,admin:ssh_signing_key
gh ssh-key add ~/.ssh/id_github.pub --title "$(hostname)"
gh ssh-key add ~/.ssh/id_signing.pub --type signing --title "$(hostname)"
```

GitLab: in **Preferences → SSH Keys**, add `id_gitlab.pub` with usage *Authentication* and `id_signing.pub` with usage *Signing*.

So that `git log --show-signature` can verify your own commits locally, list the signing key against your emails:

```sh
printf '%s namespaces="git" %s\n' 'you@users.noreply.github.com,you@users.noreply.gitlab.com' \
  "$(cut -d' ' -f1,2 ~/.ssh/id_signing.pub)" > ~/.ssh/allowed_signers
```

Check that everything works:

```sh
ssh -T git@github.com
ssh -T git@gitlab.com
cd "$(mktemp -d)" && git init -q && git commit -q --allow-empty -m test && git log --show-signature
```

<details>
<summary><b>Decisions and your options</b></summary>

<br>

- **One key per host.** If one leaks, only one account is exposed. One key for everything is simpler and works fine.
- **A separate signing key.** Git can only use one signing key. A key that can only sign can fake "Verified" badges if stolen, but it can't push code.
- **No passphrases.** Typing them got tedious, and the disk is already LUKS-encrypted. Want one? Drop `-N ""` and enable an agent: `systemctl --user enable --now ssh-agent.socket`, `export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket` in `~/.zshenv`, and `AddKeysToAgent yes` in `~/.ssh/config`.
- **Hardware keys.** For a YubiKey, use `ssh-keygen -t ed25519-sk -O resident -O verify-required` and add `libfido2` to a metapac group.
- **noreply emails** keep your real address out of public commit history. GitLab's doesn't appear anywhere in the UI. It's `<user id>-<username>@users.noreply.gitlab.com`.

</details>

### 9. Font

The terminal uses [MonoLisa](https://www.monolisa.dev), which is **paid**, so it's not in this repo. After buying it:

```sh
mkdir -p ~/.local/share/fonts/MonoLisa
unzip -j MonoLisa.zip 'ttf/*.ttf' -d ~/.local/share/fonts/MonoLisa
fc-cache -f
```

Don't want to pay? Ghostty falls back to its built-in JetBrains Mono automatically. Or install a free one and change `font-family` in [`ghostty/config.ghostty`](/.config/ghostty/config.ghostty). Good free options: [Maple Mono](https://github.com/subframe7536/maple-font), [Commit Mono](https://commitmono.com), [Geist Mono](https://vercel.com/font). You don't need a Nerd Font patched version, because Ghostty ships the icons itself. The bar uses FiraCode Nerd Font, which the `fonts` group installs.

### 10. First launches

- **Neovim** asks to install its plugins the first time. Say yes. Mason then installs the language servers and formatters in the background (watch with `:Mason`). Files opened before it finishes need a `:e` to start their language server.
- **Claude Code**: run `claude` and log in.
- **Wallpaper**: the first login shows `ticket-train.gif`. Change it with `awww img ~/.config/wallpapers/<file>` and it sticks across reboots.
- **Browser**: Chromium with Bitwarden as the password manager. I turn off Chromium's own password manager, auto sign-in, and address and card autofill, plus Bitwarden's autofill popups.

## A tour of the config

```
~
├── .zshenv                  env for every process, points zsh at ~/.config/zsh
├── .claude/                 Claude Code settings, statusline, global instructions
└── .config/
    ├── metapac/             every package, grouped by tool
    ├── hypr/                Hyprland (Lua), hypridle, hyprlock
    ├── waybar/  mako/       bar and notifications
    ├── wallpapers/
    ├── ghostty/             terminal
    ├── tmux/  workmux/      multiplexer and agent worktrees
    ├── zsh/                 shell
    ├── nvim/                editor
    ├── git/                 identity and signing
    └── yadm/bootstrap       first-run script
```

<details>
<summary><b>Packages: metapac + mise</b></summary>

<br>

[metapac](https://github.com/ripytide/metapac) installs everything listed in `~/.config/metapac/groups/*.toml` and reports anything installed that isn't listed. Run `metapac sync` to install, and `metapac unmanaged` to find stray packages.

| Group | What's in it |
|---|---|
| `base` | kernel, firmware, boot, sbctl, NetworkManager, ufw, reflector, yay, metapac, mise, yadm |
| `audio` | PipeWire and WirePlumber |
| `amd` / `nvidia` | CPU microcode and GPU driver for this machine |
| `desktop` | Hyprland and friends, Ghostty, waybar, mako, awww, clipboard, screenshots, media keys |
| `fonts` | Noto (incl. CJK and emoji), FiraCode Nerd Font |
| `git` | git, openssh, GitHub CLI |
| `zsh` / `tmux` / `nvim` | each tool plus what it calls out to |
| `languages` | Go, rustup, Terraform, Node (via mise) |
| `claude` | Claude Code (via mise) and jq for its statusline |
| `apps` | Chromium, Vesktop, Spotify |

Where a package comes from, in order of preference:

1. **The official repos.**
2. **A clean AUR package**: maintained upstream, or a `-bin` with no build step (`yay-bin`, `sesh-bin`, `vesktop-bin`).
3. **[mise](https://mise.jdx.dev)**, for tools that need version management (Node) or have a poor AUR package (Claude Code, workmux). metapac only accepts mise's short registry names.

Each machine lists its groups in `config.toml` under `hostname_groups`. Some packages run a **hook** the first time they install: ufw turns itself on, reflector enables its timer, and rustup sets `stable` as the default toolchain.

**Prefer plain pacman?** Every group is just a list. `yay -S --needed $(...)` over the files works, but you lose `unmanaged`, which is what keeps the machine honest.

</details>

<details>
<summary><b>Hyprland</b></summary>

<br>

Uses the Lua config from Hyprland 0.56. [`hyprland.lua`](/.config/hypr/hyprland.lua) loads one file per topic from `conf/`, then `hosts/<hostname>.lua` if it exists. Monitor modes and other per-machine settings go in the host file. Mine sets the Samsung G9 to 5120x1440@240.

- **Layout: master, centered.** On a 32:9 screen, dwindle splits into long slivers and scrolling pushed windows off-screen. With one window it fills the screen. With two they split. From three on, the main window sits in the middle. On a 16:9 screen, dwindle is a fine choice.
- **Looks: defaults.** The only changes are no logo, no splash, and animations at about 4x speed.
- **Input:** fast key repeat (50/s after 250 ms), cursor hides while typing, and three-finger swipes switch workspaces on laptops.
- **Two modes.** Resize mode lets you hold hjkl. Session mode is one keypress to lock, reload or exit, so there's no power menu app.
- **Autostart:** polkit agent, hypridle, awww and waybar. mako starts on demand through D-Bus.
- **Login:** no display manager. [`.zprofile`](/.config/zsh/.zprofile) runs `start-hyprland` when you log in on tty1. Other ttys stay plain consoles you can fix things from.
- **Every bind has a description**, so `hyprctl binds` doubles as a cheat sheet.

The bar is [waybar](https://github.com/Alexays/Waybar): workspaces and active mode on the left, clock in the middle (hover for a calendar and UTC), and on the right do-not-disturb, mic and screen-share indicators, failed systemd units, Wi-Fi, volume and tray. Most modules only show up when they have something to say. Notifications are [mako](https://github.com/emersion/mako), which needs four lines of config. Wallpapers are [awww](https://github.com/LGFae/awww), and it remembers the last one. The screen locks after 10 minutes with a bare hyprlock: clock and password box. Suspend is deliberately not bound.

**Alternatives I looked at:** niri (scrolling), swaync and dunst (heavier notifications), and full shells like Noctalia and Caelestia, which replace the bar, launcher and lock screen with one big app.

</details>

<details>
<summary><b>Ghostty</b></summary>

<br>

Three lines: MonoLisa, Kanagawa Dragon, and `command = direct:tmux new -A -s main`. Every window you open attaches to the same tmux session, so tmux starts here rather than from zsh, and IDE terminals don't end up nesting tmux.

</details>

<details>
<summary><b>zsh</b></summary>

<br>

No framework. [`.zshrc`](/.config/zsh/.zshrc) is a list of `plug` lines and no logic:

- **[`plug`](/.config/zsh/plug.zsh)** is about 35 lines. `plug owner/repo` clones a GitHub repo once, compiles it and sources it. `plug owner/repo@v1.2` pins a tag. `plug /some/file.zsh` sources a local file if it exists. `plug-update` updates everything. I replaced zap with it after finding bugs in zap's own plugins.
- **Two plugins:** autosuggestions and syntax highlighting.
- **[Prompt](/.config/zsh/prompt.zsh)**, hand-written instead of starship:
  - **Left:** directory and git status, from one `git status` call.
  - **Right:** how long the last command took, its exit code, background jobs, the Node or Go version when the folder uses it, and the AWS profile.
  - `user@host` only shows over SSH.
- **[Vi mode](/.config/zsh/vim.zsh)** with no plugin:
  - Block cursor in normal mode, beam in insert mode.
  - `v` opens the command in Neovim.
  - Text objects like `ci"` work.
  - Up arrow searches history by what you've typed.
- **[Tools](/.config/zsh/tools.zsh):**
  - **mise:** its per-prompt hook is removed, which saved about 6 ms per prompt. After `mise use`, run `cd .` to pick up the change.
  - **fzf:** <kbd>Ctrl</kbd>+<kbd>R</kbd>, <kbd>Ctrl</kbd>+<kbd>T</kbd> and <kbd>Alt</kbd>+<kbd>C</kbd>.
  - **zoxide** replaces `cd`. It's turned off inside Claude Code, so an agent's `cd` can't land in the wrong place.
- **Per-machine:** `~/.config/zsh/local.zsh` is loaded if it exists and isn't tracked. Work aliases and secrets go there.
- **Tidy `$HOME`:** [`~/.zshenv`](/.zshenv) moves zsh, Go, Cargo, rustup and npm caches under `~/.config`, `~/.local/share` and `~/.cache`.

**Rejected:**
- starship: the slowest prompt I measured.
- powerlevel10k: barely maintained now.
- zsh-vi-mode: overrides other keybindings.
- zsh-autocomplete: lags.
- atuin: fzf's history search is enough.
- eza, bat: not missed.

</details>

<details>
<summary><b>tmux</b></summary>

<br>

[One file](/.config/tmux/tmux.conf), no plugins, prefix stays <kbd>Ctrl</kbd>+<kbd>B</kbd>.

- **<kbd>Ctrl</kbd>+<kbd>h/j/k/l</kbd> moves between Neovim splits, tmux panes and fzf**, with no vim-tmux-navigator. tmux passes the keys through when the pane is running nvim, zsh or fzf. Neovim and zsh each have a few lines that hand off to `tmux select-pane` at the edge.
- **[sesh](https://github.com/joshmedeski/sesh)** on <kbd>prefix</kbd> <kbd>s</kbd>: fuzzy-pick a session, or create one for any directory zoxide knows.
- **[workmux](https://github.com/raine/workmux)** runs one git worktree per window, each with its own Claude Code agent. A sidebar shows each agent's status, and <kbd>prefix</kbd> <kbd>a</kbd> opens the dashboard.
- **Status bar** at the top (so it doesn't sit against Neovim's), hand-written in Kanagawa colours. The session name turns red while the prefix is held.
- **Active pane:** heavy border lines with arrows pointing at it.

**Dropped:**
- TPM, tmux-sensible and tmux-yank: Ghostty already copies to the clipboard.
- resurrect and continuum: sesh gets a session back in one keypress.
- The catppuccin theme.

</details>

<details>
<summary><b>Neovim</b></summary>

<br>

Built for Neovim 0.12 with its built-in plugin manager, `vim.pack`. The lockfile is committed. [`init.lua`](/.config/nvim/init.lua) is four lines. Options, keymaps and autocmds live in `lua/config/`, and each plugin's setup lives in its own file in `plugin/`.

| Plugin | Why |
|---|---|
| kanagawa.nvim | the theme everything else matches |
| snacks.nvim | picker, indent guides, big-file handling, all in one plugin |
| blink.cmp | completion with good fuzzy matching and VS Code-style snippets |
| nvim-treesitter | parsers for the languages I use (`main` branch, pinned) |
| mason.nvim + nvim-lspconfig | install and configure language servers |
| conform.nvim | format on save |
| oil.nvim | edit directories like buffers |
| vim-fugitive + gitsigns | git |
| vim-sleuth + nvim-web-devicons | indent detection, icons |

- **Languages:** TypeScript/JavaScript, Astro, Tailwind, Go, Rust, Python, Lua and Terraform. Mason installs the tools listed in [`plugin/mason.lua`](/.config/nvim/plugin/mason.lua) on startup.
- **JS formatting follows the project:** Biome, oxfmt or Prettier, whichever the project has a config for. The same goes for the ESLint, Biome and oxlint servers.
- **LSP keys are Neovim's built-ins** (`grn`, `gra`, `grr`, `gri`, `K`) plus `gd`, `gD` and `gl`.
- **Statusline:** Neovim's default.

**Dropped:** lazy.nvim, telescope, lualine, autopairs, surround, todo-comments and render-markdown.

To change languages, edit `plugin/mason.lua`, `plugin/lsp.lua`, `plugin/treesitter.lua` and `plugin/format.lua`.

</details>

<details>
<summary><b>Git</b></summary>

<br>

[`git/config`](/.config/git/config) signs every commit with the SSH signing key. Git can't tell which SSH key a push will use, so the identity follows the remote instead: an `includeIf "hasconfig:remote.*.url:git@gitlab.com:*/**"` switches to the GitLab noreply email for GitLab repos. A new repo with no remote uses the GitHub identity until you add one.

The same trick handles a work account. Add an SSH host alias such as `github-work` with its own key, and an `includeIf` on `git@github-work:*/**` pointing at a file with the work name and email.

</details>

<details>
<summary><b>Claude Code</b></summary>

<br>

- **[`settings.json`](/.claude/settings.json):**
  - Vim editor mode.
  - No `Co-Authored-By` lines.
  - Auto memory off. Memory goes in `CLAUDE.md` instead, which you can read and track.
  - Updates come from mise rather than the auto-updater.
  - Auto permission mode, with prompts before `git push`, PRs, and Terraform or Pulumi changes.
  - Credential files can't be read.
- **[`statusline.zsh`](/.claude/statusline.zsh)** shows the model, effort, tokens, and the 5-hour and 7-day limits with time until reset, in Kanagawa colours. It takes about 6 ms.
- **[`CLAUDE.md`](/.claude/CLAUDE.md)** holds my global instructions: commit style, IaC caution, the comment philosophy and the package rules. **It's about me.** Write your own.

</details>

## Keybindings

<details>
<summary><b>Hyprland</b> (<kbd>Super</kbd> is the modifier)</summary>

<br>

| Keys | Action |
|---|---|
| <kbd>Super</kbd> <kbd>Return</kbd> | terminal |
| <kbd>Super</kbd> <kbd>Space</kbd> | launcher |
| <kbd>Super</kbd> <kbd>b</kbd> | toggle bar |
| <kbd>Super</kbd> <kbd>Shift</kbd> <kbd>s</kbd> | screenshot a region to the clipboard |
| <kbd>Print</kbd> | screenshot the screen to the clipboard |
| <kbd>Super</kbd> <kbd>q</kbd> / <kbd>f</kbd> / <kbd>v</kbd> | close / fullscreen / float |
| <kbd>Super</kbd> <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd> | focus |
| <kbd>Super</kbd> <kbd>Shift</kbd> <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd> | move window |
| <kbd>Super</kbd> <kbd>c</kbd> | swap with the main window |
| <kbd>Super</kbd> <kbd>,</kbd> / <kbd>.</kbd> | main window narrower / wider |
| <kbd>Super</kbd> <kbd>[</kbd> / <kbd>]</kbd> | previous / next window |
| <kbd>Super</kbd> <kbd>Ctrl</kbd> <kbd>h</kbd> / <kbd>l</kbd> | rotate the layout |
| <kbd>Super</kbd> <kbd>1</kbd>…<kbd>0</kbd> | workspace 1–10 |
| <kbd>Super</kbd> <kbd>Shift</kbd> <kbd>1</kbd>…<kbd>0</kbd> | move window to workspace |
| <kbd>Super</kbd> <kbd>Tab</kbd> | previous workspace |
| <kbd>Super</kbd> <kbd>Ctrl</kbd> <kbd>j</kbd> / <kbd>k</kbd> | next / previous workspace |
| <kbd>Super</kbd> drag / right-drag | move / resize |
| <kbd>Super</kbd> <kbd>r</kbd> | resize mode: <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd>, <kbd>Esc</kbd> to leave |
| <kbd>Super</kbd> <kbd>Esc</kbd> | session mode: <kbd>l</kbd> lock, <kbd>r</kbd> reload, <kbd>e</kbd> exit |
| <kbd>Super</kbd> <kbd>n</kbd> / <kbd>Shift</kbd> <kbd>n</kbd> | dismiss notification / all |
| <kbd>Super</kbd> <kbd>u</kbd> | bring back the last notification |
| <kbd>Super</kbd> <kbd>Shift</kbd> <kbd>d</kbd> | do not disturb |

Media, volume and brightness keys work, including on the lock screen.

</details>

<details>
<summary><b>tmux</b> (prefix is <kbd>Ctrl</kbd> <kbd>b</kbd>)</summary>

<br>

| Keys | Action |
|---|---|
| <kbd>Ctrl</kbd> <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd> | move between panes, Neovim splits and fzf |
| <kbd>prefix</kbd> <kbd>s</kbd> | sesh: pick or create a session |
| <kbd>prefix</kbd> <kbd>a</kbd> | workmux dashboard |
| <kbd>prefix</kbd> <kbd>"</kbd> / <kbd>%</kbd> | split, keeping the current directory |
| <kbd>prefix</kbd> <kbd>[</kbd> then <kbd>v</kbd> / <kbd>y</kbd> | copy mode: select / copy to the clipboard |

</details>

<details>
<summary><b>zsh</b></summary>

<br>

| Keys | Action |
|---|---|
| <kbd>Esc</kbd> | normal mode |
| <kbd>v</kbd> (normal mode) | edit the command in Neovim |
| <kbd>↑</kbd> <kbd>↓</kbd> or <kbd>k</kbd> <kbd>j</kbd> | history matching what you've typed |
| <kbd>Ctrl</kbd> <kbd>r</kbd> / <kbd>Ctrl</kbd> <kbd>t</kbd> / <kbd>Alt</kbd> <kbd>c</kbd> | fzf: history / files / cd |
| <kbd>Ctrl</kbd> <kbd>a</kbd> / <kbd>Ctrl</kbd> <kbd>e</kbd> | start / end of line |

`cd` is zoxide, so `cd proj` jumps to the most-used directory matching `proj` from anywhere. Git aliases are in [`aliases.zsh`](/.config/zsh/aliases.zsh).

</details>

<details>
<summary><b>Neovim</b> (leader is <kbd>Space</kbd>)</summary>

<br>

| Keys | Action |
|---|---|
| <kbd>Space</kbd> <kbd>p</kbd> <kbd>f</kbd> / <kbd>Ctrl</kbd> <kbd>p</kbd> | find files / git files |
| <kbd>Space</kbd> <kbd>p</kbd> <kbd>s</kbd> | grep |
| <kbd>Space</kbd> <kbd>p</kbd> <kbd>v</kbd> | file browser (oil); <kbd>-</kbd> goes up |
| <kbd>Space</kbd> <kbd>f</kbd> | format |
| <kbd>Space</kbd> <kbd>g</kbd> <kbd>s</kbd> | git status (fugitive) |
| <kbd>g</kbd> <kbd>d</kbd> / <kbd>g</kbd> <kbd>l</kbd> | go to definition / line diagnostics |
| <kbd>g</kbd> <kbd>r</kbd> <kbd>n</kbd> / <kbd>a</kbd> / <kbd>r</kbd> / <kbd>i</kbd> | rename / code action / references / implementation |
| <kbd>Space</kbd> <kbd>y</kbd> | yank to the system clipboard |
| <kbd>Space</kbd> <kbd>s</kbd> | replace the word under the cursor everywhere |
| <kbd>J</kbd> / <kbd>K</kbd> (visual) | move the selection down / up |

</details>

## Making it yours

Things that are about me or my hardware:

- [ ] `~/.config/metapac/config.toml`: your hostname and groups
- [ ] `~/.config/hypr/hosts/strudel-linux.lua`: rename it to your hostname and set your monitor, or delete it
- [ ] `~/.config/git/config` and `git/gitlab`: your name, emails and signing key path
- [ ] `~/.claude/CLAUDE.md`: your own instructions
- [ ] `~/.claude/settings.json`: the `ask` and `deny` lists, and the model in `modelSettings`
- [ ] `~/.config/ghostty/config.ghostty`: a font you own
- [ ] `~/.config/hypr/conf/autostart.lua`: the default wallpaper
- [ ] reflector's `--country`
- [ ] Caps Lock: my keyboard's firmware already disables it. You might want `kb_options = "caps:escape"` in `conf/input.lua`

## Day to day

| Task | Command |
|---|---|
| Install what's listed | `metapac sync` |
| Find what isn't listed | `metapac unmanaged` |
| Update everything | `metapac update-all` |
| Update zsh plugins | `plug-update` |
| Update Neovim plugins | `:lua vim.pack.update()` |
| Commit config changes | `yadm add -u && yadm commit` |
| See which files are tracked | `yadm ls-files` |
| Test Hyprland binds | `hyprctl binds` |

## Known issues

- **Samsung G9 + NVIDIA: the screen won't come back after it turns off.** This is an [aquamarine 0.15 bug](https://github.com/hyprwm/aquamarine/issues/428). After the screen powers off, Hyprland hangs when the monitor reconnects, and only a hard power-off recovers. For now hypridle only locks and never turns the screen off. Also turn off *Auto Source Switch+* in the G9's menu. Once a fixed aquamarine ships, add the DPMS listener back to `hypridle.conf`.
- **waybar's `hyprland/workspaces` module can't switch workspaces** with the Lua config, because it still sends old-style dispatch commands. The bar uses the generic `ext/workspaces` module instead.
- **nvim-treesitter is archived.** The `main` branch still works on 0.12 and is pinned in the lockfile. It will need replacing eventually.
- **After `mise upgrade workmux`**, restart tmux (or run `workmux sidebar off && workmux sidebar on`). The sidebar hooks point at the old version's path.

## Windows side (dual boot)

Two files in [`.github/windows/`](/.github/windows) make the Windows install mostly hands-off:

| File | What it does |
|---|---|
| [`autounattend.xml`](/.github/windows/autounattend.xml) | Answers Windows Setup for you: skips the Microsoft account, removes bloat, applies the dual-boot fixes |
| [`winget.json`](/.github/windows/winget.json) | Every app I install, as a `winget import` list |

The answer file has no passwords, no Wi-Fi details and no computer name in it. Setup asks for your local account and Wi-Fi, so anyone can use it as is.

<details>
<summary><b>Using the answer file</b></summary>

<br>

1. **Optional: make your own copy.** Open [my settings, pre-filled in the generator][unattend-settings], change anything you like (language, keyboard, which apps to remove), and download it. The link at the top of the XML opens the same page.
2. **Put it on a Ventoy USB** next to the Windows ISO and add this to `ventoy/ventoy.json`. When you boot the ISO, Ventoy asks whether to use the template:
   ```json
   "auto_install": [
     { "image": "/OSimages/Win11_25H2_English_x64_v2.iso", "template": ["/ventoy/script/autounattend.xml"] }
   ]
   ```
   No Ventoy? Copy `autounattend.xml` to the root of a normal Windows USB made with the Media Creation Tool.
3. **Partition:** pick the Windows partition you made earlier, click *Format*, then *Next*. Everything else runs by itself until the account and Wi-Fi screens.

> [!NOTE]
> If Windows has no driver for your Wi-Fi card, setup can't get online. My Netgear adapter only ships an installer, so I installed it on another PC, exported the driver to a USB stick, and loaded it at the network screen with *Install driver*. That dialog wants a **folder**, not a file. Ethernet avoids all of this.

</details>

<details>
<summary><b>What the answer file sets</b></summary>

<br>

- **Dual boot:** Fast Startup off, hibernation off, and the hardware clock in UTC (`RealTimeIsUniversal`), so Linux and Windows agree on the time and on the state of the disks.
- **Install:** Windows 11 Pro with the public generic key. Activate it with your own licence afterwards. TPM, Secure Boot and RAM checks are bypassed. The account is local, created during setup.
- **Explorer:** file extensions and hidden files shown (protected OS files stay hidden), opens to This PC, classic right-click menu.
- **Taskbar and Start:** left-aligned, no search box, Task View or widgets, nothing pinned, *End Task* on right-click.
- **Look and feel:** dark mode, no transparency, most animations off, mouse acceleration off, Sticky Keys off.
- **Caps Lock and Scroll Lock are disabled.** My keyboard doesn't use Caps Lock. Untick this in the generator if yours does.
- **Turned off:** Copilot, Recall, Bing in search, ads and suggestions, BitLocker auto-encryption, VBS/HVCI (better game performance), Smart App Control, Edge's startup boost and first-run screens, automatic reboots while signed in.
- **Removed:** nearly every preinstalled app (Xbox, Teams, Outlook, Clipchamp, News, Weather and so on), OneDrive, Internet Explorer, WordPad, Media Player, PowerShell 2.

</details>

<details>
<summary><b>After the first boot</b></summary>

<br>

1. Run Windows Update and *Microsoft Store → Downloads → Update all* until nothing is left. Reboot, and repeat once.
2. Install the apps:
   ```powershell
   winget import -i winget.json --accept-package-agreements --accept-source-agreements
   ```
   That's Steam, Epic, Valorant, Discord, Spotify, Chromium, Blender, 7-Zip, PowerToys and O&O ShutUp10.
3. Rename the PC: *Settings → System → About → Rename this PC*.
4. Then the manual bits:
   - **PowerToys:** turn off everything except FancyZones.
   - **Task Manager → Startup apps:** disable all of them.
   - **O&O ShutUp10:** winget doesn't add a Start menu shortcut, so run it from `%LOCALAPPDATA%\Microsoft\WinGet\Packages\`, then apply the recommended settings.
   - **Power:** High Performance plan, sleep off.
   - **Sound:** disable every device you don't use, and set *Communications* to *Do nothing*.
   - **Games:** point the Steam, Epic and Valorant libraries at the second drive.
   - **Chromium:** set it up the same way as on Linux.

</details>

---

<p align="center">
  Looking for the old i3 / AwesomeWM / Sway setup? It lives on the <a href="https://github.com/Lil-Strudel/.dotfiles/tree/legacy"><code>legacy</code></a> tag.
</p>

[unattend-settings]: https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=en-US&Locale=en-US&Keyboard=00000409&GeoLocation=244&PEMode=Default&WindowsEditionMode=Generic&WindowsEdition=pro&ProcessorArchitecture=amd64&BypassRequirementsCheck=true&ComputerNameMode=Random&TimeZoneMode=Implicit&UserAccountMode=InteractiveLocal&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=HiddenSystem&ShowFileExtensions=true&ClassicContextMenu=true&HideInfoTip=true&LaunchToThisPC=true&ShowEndTask=true&TaskbarSearch=Hide&TaskbarIconsMode=Empty&DisableWidgets=true&LeftTaskbar=true&HideTaskViewButton=true&DisableBingResults=true&StartTilesMode=Empty&StartPinsMode=Empty&DisableSac=true&DisableFastStartup=true&DisableSystemRestore=true&EnableLongPaths=true&HardenSystemDriveAcl=true&AllowPowerShellScripts=true&DisableLastAccess=true&PreventAutomaticReboot=true&DisableAppSuggestions=true&PreventDeviceEncryption=true&HideEdgeFre=true&DisableEdgeStartupBoost=true&DisablePointerPrecision=true&DeleteWindowsOld=true&DisableAutomaticRestartSignOn=true&DisableWpbt=true&PreventDeviceApps=true&EffectsMode=Custom&ThumbnailsOrIcon=true&ListviewAlphaSelect=true&DragFullWindows=true&FontSmoothing=true&DeleteEdgeDesktopIcon=true&DesktopIconsMode=Default&StartFoldersMode=Default&CoreIsolationMode=Disabled&WifiMode=Interactive&ExpressSettings=DisableAll&LockKeysMode=Configure&CapsLockInitial=Off&CapsLockBehavior=Ignore&NumLockInitial=On&NumLockBehavior=Toggle&ScrollLockInitial=Off&ScrollLockBehavior=Ignore&StickyKeysMode=Disabled&ColorMode=Custom&SystemColorTheme=Dark&AppsColorTheme=Dark&AccentColor=%230078d4&WallpaperMode=Default&LockScreenMode=Default&Remove3DViewer=true&RemoveBingSearch=true&RemoveCamera=true&RemoveClipchamp=true&RemoveClock=true&RemoveCopilot=true&RemoveCortana=true&RemoveDevHome=true&RemoveWindowsHello=true&RemoveFamily=true&RemoveFeedbackHub=true&RemoveGameAssist=true&RemoveGetHelp=true&RemoveHandwriting=true&RemoveInternetExplorer=true&RemoveMailCalendar=true&RemoveMaps=true&RemoveMathInputPanel=true&RemoveMixedReality=true&RemoveZuneVideo=true&RemoveNews=true&RemoveOffice365=true&RemoveOneDrive=true&RemoveOneNote=true&RemoveOneSync=true&RemoveOutlook=true&RemovePaint3D=true&RemovePeople=true&RemovePhotos=true&RemovePowerAutomate=true&RemovePowerShell2=true&RemovePowerShellISE=true&RemoveQuickAssist=true&RemoveRecall=true&RemoveRdpClient=true&RemoveSkype=true&RemoveSolitaire=true&RemoveSpeech=true&RemoveStepsRecorder=true&RemoveStickyNotes=true&RemoveTeams=true&RemoveGetStarted=true&RemoveToDo=true&RemoveVoiceRecorder=true&RemoveWallet=true&RemoveWeather=true&RemoveWindowsMediaPlayer=true&RemoveWordPad=true&RemoveXboxApps=true&RemoveYourPhone=true&SystemScript0=reg.exe+add+%22HKLM%5CSYSTEM%5CCurrentControlSet%5CControl%5CTimeZoneInformation%22+%2Fv+RealTimeIsUniversal+%2Ft+REG_DWORD+%2Fd+1+%2Ff%0D%0Apowercfg.exe+%2Fhibernate+off&SystemScriptType0=Cmd&AppLockerMode=Skip
