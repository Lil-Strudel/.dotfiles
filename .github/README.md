# .dotfiles

Here are my dotfiles!

If you would like to setup your linux env just like mine, here's how you can do that!

Steps:
Install arch using archinstall
Dont forget to install networkmanager/pipewire/xorg through archinstall
Other packages to install

```
noto-fonts noto-fonts-cjk noto-fonts-emoji git openssh firefox kitty thunar tmux unzip starship acpi feh rofi pavucontrol picom zsh exa xorg-xrandr playerctl xclip fzf ripgrep xsecurelock flameshot neovim gvfs thunar-volman
```

Install yay

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Install aur packages with yay

```
yay -Syu awesome-git nvim-packer-git
```

Setup Git

```
You're on your own for this one
```

Setup dotfiles
You may have to delete conflicting files!

```
git clone --bare <git-repo-url> $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Make ZSH the default Shell

```
chsh -s /bin/zsh
```

Install Zap

```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
```
