# About me

Software developer at home, DevOps engineer at work. I write a lot of infrastructure as code (Terraform, Pulumi) and build apps in many languages. My machine runs Arch Linux with Hyprland, Ghostty, tmux, zsh in vi mode and Neovim. Dotfiles are tracked with yadm.

# Git

- Write every commit message as a Conventional Commit.
- Never add attribution of any kind to commits or pull requests: no `Co-Authored-By` trailers, no "Generated with Claude Code" lines.
- For feature work, create a branch or worktree and commit freely. Ask before pushing or opening a pull request.

# Infrastructure as code

- Before editing IaC, make sure my previous changes are committed. If they aren't, stop and ask.
- Run `plan` / `preview` freely. Never `apply`, `up`, `destroy` or change state without asking.

# Comments in code

I follow Rob Pike ("Notes on Programming in C", Comments) and Jeff Atwood ("Coding Without Comments").

- Clear code with good names comes first. If code needs a comment to be understood, try rewriting it before commenting it.
- Never write comments that restate what the code does. Comment only the non-obvious *why*: a constraint, a workaround, a surprising decision.
- Comments go stale and mislead; fewer, accurate comments beat many.
- Never litter code with comments, section banners or commented-out code.
- Config files (dotfiles, YAML, TOML, tmux, zsh, etc.) get no comments at all.

# Config work

When building or changing configs, interview first, then build. For every setting, plugin, file or tool, say what it does and what happens if it is removed; I decide. Keep it minimal and hand-rolled over plugin managers. Measure performance with built-in tools rather than installing benchmark tools; the budget is "indistinguishable from zero".

# Packages

Packages are declared in metapac groups at `~/.config/metapac/groups/<distro>/*.toml` (`arch/` and `debian/`), one group per tool area. Arch (official or a clean AUR / `-bin` package with no build step) versus mise is case by case: mise is preferred for tools that need version management (node) or whose AUR package is poor (claude). metapac only accepts mise registry short names (`workmux`, not `github:raine/workmux`). zsh plugins are cloned by my own `plug` function in `~/.config/zsh/plug.zsh`, never installed as packages. `metapac sync` needs sudo, so ask me to run it.

# Memory

When I ask you to remember something, add it to this file (or the project's `CLAUDE.md` if it is project specific).
