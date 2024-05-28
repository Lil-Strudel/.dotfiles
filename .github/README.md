# Lil Strudel's .dotfiles

![shield](https://img.shields.io/badge/Made%20with-love-20B2AA?style=for-the-badge)

Here are my dotfiles as well as some additional information on how I like to setup my computers. On Debian I am running Sway, whereas on Arch I am running AwesomeWM. I am currently in transition to using Debian/Sway on all my machines, but I will be leaving my Awesome (and Tokyo Night) configs in here for historical purposes.

## Using my dotfiles

[Yadm Docs on this topic](https://yadm.io/docs/getting_started)

[Install yadm](https://yadm.io/docs/install) onto your system.

```
sudo pacman -S yadm
```

```
sudo apt -y install yadm
```

Run yadm clone

```
yadm clone git@github.com:Lil-Strudel/.dotfiles.git # Or for you http git weirdos: https://github.com/Lil-Strudel/.dotfiles.git
```

Add the classes you want applied

```
yadm config local.class Strhuedel # Will apply the Strhuedel theme
```

If you are me

```
yadm decrypt
```

## More info for people who care

### yadm

yadm is pretty awesome. I am using yadm to manage my dotfiles. Essentially yadm is just a wrapper around a git bare repo (what I used to use) but with super powers.

Using `##` in a file name you are able to apply conditional files based off of classes or system config. I am using this to manage the different themes I use (Ie. Tokyo Night and Strhuedel).

To create a symlink for conditionally applied files, run

```
yadm config local.class *class name*
```

or

```
yadm config --add local.class *class name*
```

yadm also lets you encrypt files to save in your dotfiles. So while I am not putting any sensitive information in source control (like ssh keys) I can still keep MonoLisa in my dotfiles without worring about infringing on any licensing.

### Desktop Environments

The two desktop environments that I use are AwesomeWM and Sway. The big difference between the two is that Awesome runs on Xorg, while Sway runs on Wayland. For this reason you will see files appended with `##class.Xorg` and `##class.Wayland`.

These are files that only apply when using those specific desktop environments.

### Themes

Up until recently, I was using Tokyo Night for everything. My terminal, neovim, tmux theme, hell even my portfolio was Tokyo Night. I think it is a very lovely color scheme, but recently I have found myself more alured to warmer colors. GruvBox is not really my jam, so I decided to create my own color theme `Strhuedel`.

This is why you will see files appended with `##class.Tokyo-Night` and `##class.Strhuedel`. What makes yadm so cool is if you want to switch between themes, you can simply change your local class (granted not everything has been themed in both colors).

### Operating Systems

I use Arch btw!

Sometimes.....

Ok I guess not anymore.

I used Arch for 2-3 years and I love it! Maybe a little too much. I feel I've gotten too confortable with Arch and Awesome. Thats why I am making a push to try out Debian and Sway instead. I think I might appreciate the stability of Debian (especially for my work laptop).

SYKE!!! Switching back to arch on my Desktop. Its a bit to rough trying to work with Debian

Additionally I almost always dual boot with Windows 10. I gamed on Arch and it worked near perfectly. The problem I had is Valorant only runs on Windows, and you can't have 240hz over DisplayPort with Linuxes scuffed Nvidia support.

### Installing Window Managers

#### Sway on Arch

Install arch using archinstall:

- Mirrors: United States
- Bootloader: Grub
- Swap: False
- Profile: Minimal
- Audio: Pipewire
- Kernels: Linux
- Network configuration: Copy ISO
- Optional repositories: multilib

Additional packages:
General:

```
yadm sway polkit swaylock swayidle waybar wofi brightnessctl pavucontrol git openssh zsh kitty starship neovim firefox curl tmux wl-clipboard eza fzf ripgrep unzip noto-fonts noto-fonts-cjk noto-fonts-emoji
```

Nvidia Specific:

```
mesa xf86-video-nouveau libva-mesa-driver mesa-vdpau vulkan-icd-loader vulkan-nouveau
```

Clone dotfiles as per above

Select theme as per above

[Install yay from binary](https://github.com/Jguer/yay?tab=readme-ov-file#binary)

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
```

Install aur specific lovelies

```
yay -S swww
```

Change the shell to zsh.

```
chsh -s /bin/zsh
```

And [install Zap](https://github.com/zap-zsh/zap) to manage the zsh plugins

```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
```

[Install Go](https://github.com/moovweb/gvm)

```
sudo apt-get install bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.22.3 -B # or whatever is latest
gvm use go1.22.3 --default

```

[Install TPM](https://github.com/tmux-plugins/tpm)

```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

### Installing operating systems

#### Arch Linux

To install Arch Linux I recommend using Archinstall.

When using Archinstall, its pretty straightforward, but the big things to renember are to:

- Install networkmanager
- Install pipewire
- Install Xorg (if using Awesome)
- Install appropriate graphics driver

When it asks what additional packages you would like to install, here is my list:

```
noto-fonts noto-fonts-cjk noto-fonts-emoji git openssh firefox kitty thunar tmux unzip starship acpi feh rofi pavucontrol picom zsh exa xorg-xrandr playerctl xclip fzf ripgrep xsecurelock flameshot neovim gvfs thunar-volman
```

Then once the install is complete, it is time to [install Yay](https://github.com/Jguer/yay)!

```
pacman -Sy --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Once yay is installed, you can install the latest version of Awesome.

```
yay -Syu awesome-git
```

From there clone in the dot files using the instructions above.

Change the shell to zsh.

```
chsh -s /bin/zsh
```

And [install Zap](https://github.com/zap-zsh/zap) to manage the zsh plugins

```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
```

#### Debian

TODO: Write this

Might be giving up on Debian tbh.... AUR is too nice.

packages to install

```
sudo apt install yadm network-manager sway neovim firefox-esr zsh waybar wofi brightnessctl swayidle swaylock kitty gnupg2 curl build-essential unzip eza tmux wl-clipboard ripgrep xwayland fonts-noto-cjk fonts-noto-color-emoji pavucontrol
```

Change the shell to zsh.

```
chsh -s /bin/zsh
```

And [install Zap](https://github.com/zap-zsh/zap) to manage the zsh plugins

```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

Clone the dotfiles as per the instructions above

Install SWWW

- Clone the repo
- Install Rust
- Install make dependancies

Clone the repo

```
git clone https://github.com/LGFae/swww.git
```

[Rust](https://www.rust-lang.org/tools/install)

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

```

Make Dependancies

```
sudo apt install liblz4-dev pkg-config

```

[Build the Binary](https://github.com/LGFae/swww)

```
cargo build --release
```

Move Binary to bin

```
cd ./target/release
sudo mv -t /usr/local/bin swww swww-daemon
```

[Install starship](https://starship.rs/)

```
curl -sS https://starship.rs/install.sh | sh
```

[Install Go](https://github.com/moovweb/gvm)

```
sudo apt-get install bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.22.3 -B # or whatever is latest
gvm use go1.22.3 --default

```

[Install TPM](https://github.com/tmux-plugins/tpm)

```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

#### Windows 10

Despite it being insecure, I like to install Windows on an offline account. Windows only has my games so I don't really care if its not the most secure setup.

Once Windows is installed, update system and update Microsoft Store. Several times. Reboot, and update again. Thanks Windows for sucking.

[Install Chocolatey](https://chocolatey.org/install)

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Install apps [sophiapp](https://github.com/Sophia-Community/SophiApp) and [Shutup10](https://community.chocolatey.org/packages/shutup10) using [chocolatey](https://community.chocolatey.org/packages/sophiapp)

```
choco install sophiapp shutup10
```

Run Sophiapp and completely clean Windows.

Run Shutup10 (Win+R and type OOSU10) and disable all the dumb stuff from Windows.

#### Note for dual booting

I like to install Windows first, and make the partition table before installing Windows.

Here is my partition layout:

- 1gb fat32 Boot /boot
- 32/64gb Swap (if using Debian)
- 1/2 drive size ntfs - Windows
- 200gb Ext4 Linux /
- Rest of drive Ext4 Strudel /strudel

I like to have a separate partition for my files in Linux, so I can wipe/switch my OS without losing all my files. The reason why I don't have a /home partition is because I usually want all my configs and stuff to get wiped, just not my code and such.

Just don't forget to chown the seperate partition

```
sudo chown strudel /strudel/
```

and make a sym link

```
ln -s /strudel ~/strudel
```

If you installed grub and want to add windows to it

```
sudo pacman -S os-prober
```

```
sudo nvim /etc/default/grub
```

Remove the # on the line GRUB_DISABLE_OS_PROBER=false

```
sudo mkdir /mnt/windows
sudo mount -t ntfs3 /dev/nvme0n1p3 /mnt/windows
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

If that doesn't work, it might because you partition the EFI partition.... Don't ask me how I know.

We're gonna use [bcdboot](<https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-8.1-and-8/hh824874(v=win.10)?redirectedfrom=MSDN>) to fix it

To fix that you are going to need a bootable windows media, repair this computer, troubleshoot, command-line

```
bcdboot D:\Windows
```

Retry the grub steps now
