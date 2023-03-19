# arch-install

Guide to install arch the way I like it

Steps:
Install arch using archinstall
Dont forget to install networkmanager/pipewire/xorg through archinstall
Other packages to install - noto-fonts neofetch git openssh firefox kitty thunar picom neovim tmux unzip

Install yay

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Install aur packages with yay

```
yay -Syu awesome-git neovim-git nvim-packer-git
```

Get an xinitrc

```
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

Remove Unneeded commands from xinitrc

```
twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
exec xterm -geometry 80x66+0+0 -name login
```

Add awesome to xinitrc

```
exec awesome
```

Copy awesome config file to .config

```
mkdir -p ~/.conifg/awesome
cp /etc/xdg/awesome/rc.lua ~/.config/awesome/rc.lua
```

Setup dotfiles

```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Make ZSH the default Shell
```
chsh -s /bin/zsh
```

Install Zap
```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
```



