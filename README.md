# arch-install
Guide to install arch the way I like it

Steps:
Install arch using archinstall 
  Dont forget to install networkmanager/pipewire/xorg through archinstall
  Other packages to install - vim noto-fonts neofetch xterm

Install awesome with pacman
```
sudo pacman -Syu awesome
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
