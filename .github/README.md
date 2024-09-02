# Lil Strudel's .dotfiles

![shield](https://img.shields.io/badge/Made%20with-love-20B2AA?style=for-the-badge)

## Quick Start

#### Install yadm

Arch

```bash
sudo pacman -S yadm
```

<details>
<summary>Debian</summary>

```bash
sudo apt -y install yadm
```

</details>

#### Clone dotfiles

```bash
yadm clone https://github.com/Lil-Strudel/.dotfiles.git
```

#### Select Theme

```bash
yadm config local.class Strhuedel
```

#### If you are me

```bash
yadm decrypt
```

## About My Dotfiles

Over the course of my Linux journey, I have played around with various distros and desktop environments. This repo contains my configuration for pretty much everything that I use in Linux. I also have written sections describing things I wish I knew years ago when first getting into Linux.

I really like to keep things minimal. I have spend hundreds of hours doing things to avoid installing additional packages. As of late, I have been quite a bit more lenient with that sort of stuff, but you will notice a lot of effort has been put into keeping this lightweight.

Over the years, my configs and preferences have changed in various ways. A big example of this is my recent switch to Strhuedel, a theme I made, from Tokyo Night which has been my de-facto standard color scheme. Despite this, I still love my old configs and strive to keep them functional despite not being in use.

The primary way I manage to keep old config (even conflicting configs) function within the same repo is by using the tool [yadm](https://github.com/TheLocehiliosan/yadm).

**About yadm**

yadm is pretty awesome. Essentially it is just a wrapper around a git bare repo, which is what I have used in the past, but with super powers.

You are able to create conditional files that are only applied when certain classes are active, or if your system meets certain specifications. This combined with yadms ability to template files and conditionally insert content into files based on the conditions, makes yadm extraordinarily flexible.

Whenever the conditions are met, symlinks are created and/or files are generated based on templates to create your perfect config.

yadm also lets you encrypt files to save in your dotfiles. So while I am not putting any sensitive information in source control (like ssh keys) I can still keep MonoLisa in my dotfiles without worring about infringing on any licensing.

<details>
<summary>Helpful yadm info</summary>

**Conditional Files**

You can create a conditionally applied file by adding `##` to its file name, followed by the condition you want it applied for. [Docs on the topic](https://yadm.io/docs/alternates)

```bash
myFile#class.MyClass
```

**Templates**

You can create a conditionally applied file by adding `##template` to its file name. Now inside the file you are able to specify some conditions for content in the file. [Docs on the topic](https://yadm.io/docs/templates)

```bash
{% if yadm.os == "Darwin" %}
This block is included for MacOS
{% else %}
This block is included for any other OS
{% endif %}
```

**Classes**

To set the class, use

```bash
yadm config local.class *class name*
```

To add additional classes, use

```bash
yadm config --add local.class *class name*
```

</details>

# Install Guide

I have found a bunch of tips and tricks to help make installing Linux easier for me. In this section I will share how I setup my partitions, install Linux, dual boot with windows, and install a desktop environment.

## Determining your partition scheme

I find that the first step to setting up your work station is determining your partition layout. The key considerations when making your partition layout are:

- Are you dual booting?
- Do you want a swap partition?
- Do you want your working files separate from your OS files?

<details>
<summary>Why would I want to dual boot?</summary>

> Valorant only runs on windows.... So does the entire Adobe Suite.... Gaming is also kinda easier for the most part.... Ugghhh i hate windows

</details>
<details>
<summary>Why would I want a swap partition?</summary>

> If you plan to Hibernate your pc or have low quantities of ram, I would highly recommend having a swap. That being said, you can create a swap file which will accomplish the exact same thing, but not require a dedicated partition. For the most part, I do not use swaps on my machines, and recommend using a swap file instead of a swap partition.

</details>
<details>
<summary>Why would I want my working files separate from my OS?</summary>

> If you do a lot of OS hopping like me or generally like to wipe your OS for spring cleaning, a separate partition for all your files can save you a lot of time. No need to backup your .envs when wiping your OS, you don't lose work on branches your forgot about, ect...

</details>

For me, the answers to those questions are yes, no, yes.

Here is a fully spec'd out partition table
| Name | Size | File System | Mount Point
| ---- | ---- | ---- | ---- |
| Boot | 1gb (300mb at the least) | fat32 | /boot
| Swap | 4gb < 2x ram < 64gb | N/A* | N/A*
| Windows | 1/2 drive size | ntfs | N/A
| Linux | 30gb < 1/3 drive size > 200gb | ext4 | /
| Storage | Remaining Space | ext4 | /storage

If you are not dual booting, remove the Windows partition.
If you do not want a dedicated swap partition, remove the Swap partition.
If you do not want a separate partition for your working files, remove the Storage partition.

Easy enough, right?

> \*Note that swap partitions do not have a filesystem, nor do they get assigned a mount point. In Arch you must configure your swap partition after system install, but on Debian you can configure the swap during install by setting the partition type to swap.

## Partitioning your drive

Pretty much every OS will have a partitioning tool of some sort. Windows is ass and I am not smart enough to use Arch's, so I boot into a Ubuntu ISO and use GParted.

I like partitioning the drive before installing any OS because it makes it really easy to select/format the partitions regardless of what you are installing. Arch's partition tool is really easy to select a partition to format, but really hard to define how big a partition should be.

So boot into Ubuntu (or any other ISO with GParted) and whip up the partition table.

## Install Windows (if dual booting)

If you are dual booting, I recommend installing Windows first. If you are not installing Windows, you can skip this step.

[Click here](#windows-10-setup-guide) to see how I like to setup Windows.

## Install Linux!

Oh boy... We've made it. The part we have all been waiting for.

<details>
<summary>What distro should I use</summary>

The decision between Arch and Debian for me is pretty straight forward. Choose Arch :grin:

Sarcasm aside, Arch provides a bleeding edge environment with constant updates and a rich community. Debian provides a very stable environment where things are unlikely to change.

People say that Debian is more "user friendly," but I think if you are doing a minimal install, that is not the case. Arch has access to the AUR which makes installing pretty much everything that much easier.

I have a great appreciation for Debian... But I will leave it for my servers.

</details>

**Installing Arch**

- Boot into your Arch ISO and get connected to the internet.
- Run "archinstall"

Here are the settings I use across all Arch my Installs

- **Language:** English
- **Mirrors:** Blank or United States
- **Locales:** Default
- **Disc Configuration:**
  - Partitioning -> Manual Partitioning -> Select the correct drive
  - Boot
    - Set mountpoint to "/boot"
    - Mark to be formatted
  - Linux
    - Set mountpoint to "/"
    - Mark to be formatted
  - Storage
    - Set mountpoint to "/storage" (or "/strudel" if you are me)
    - DO NOT MARK TO BE FORMATED IF IT HAS DATA
  - Be grateful you made the partitions earlier :)
- **Bootloader:** Grub
- **Unified Kernel Images:** False
- **Swap:** I usually do False. Do true if you want a swap file.
- **Host Name:** strudel-(depends on device)
- **Root Password:**
- **User account:** You got this one (super user)
- **Audio:** Pipewire
- **Kernels:** linux
- **Additional Packages:**
- **Network Configuration:** NetworkManager
- **Timezone:** US/Mountain
- **Automatic Time Sync (NTP):** True
- **Optional Repositories:** Blank

> Important: If you are installing I3 or AwesomeWM, the selection for Profile will change! Please refer to [the next section](#install-your-desktop-environment)

Once your settings are all the way you want them, select "Install."
When it is finished, I usually skip chrooting into the new environment.
Reboot!

**Dual Booting? Configure grub to show windows**

```bash
sudo pacman -S os-prober
```

```bash
sudo vim /etc/default/grub
```

Remove the # on the line GRUB_DISABLE_OS_PROBER=false

```bash
sudo mkdir /mnt/windows
sudo mount -t ntfs3 /dev/nvme0n1p3 /mnt/windows
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo umount /mnt/windows
```

<details>
<summary>Did that not work? Here's the fix!</summary>

If os-parser does not pick up Windows, its likely because you partitioned the EFI partition.... Don't ask me how I know.

We're gonna use [bcdboot](<https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-8.1-and-8/hh824874(v=win.10)>) to fix it

- Boot into a windows media
- Click "Repair this Computer"
- Click "Troubleshoot"
- Click "command-line"

```powershell
bcdboot D:\Windows
```

Reboot and retry the grub steps now

</details>

## Install your desktop environment

**I3**

To install I3, add the following to your archinstall config:

- **Profile**:
  - Desktop
    - I3-wm
  - Graphics Driver
    - If you have a Nvidia GPU: "Nvidia (open kernel module for new GPUs, Turing+)" has been very impressive for me
    - If you have an AMD GPU: "AMD / ATI (open-source)
  - Greeter
    - I usually find these to be bloat and do not select one
    - SDDM is my go to when I do.

That is it! I3 is installed!

**AwesomeWM**

To install AwesomeWM, add the following to your archinstall config:

- **Profile**:
  - Xorg
  - Graphics Driver
    - If you have a Nvidia GPU: "Nvidia (open kernel module for new GPUs, Turing+)" has been very impressive for me
    - If you have an AMD GPU: "AMD / ATI (open-source)

Once you install yay, you will need to install the git version of AwesomeWM

```bash
yay -Syu awesome-git
```

> Note: The git version of awesome was a major version ahead of the stable version provided by Arch at the time of making these instructions. It appears that major version has since been released as stable, so these instructions might not be the best anymore.

That is it! AwesomeWM is installed!

**Sway**

> ! DO NOT INSTALL SWAY IF YOU HAVE A NVIDIA GPU!!!!! Wayland is not ready yet for Nvidia. I was able to hack it together, but seriously DO NOT DO IT.

<details>
<summary>Only continue if you hate yourself. Nvidia Guide</summary>

**Turn back! Its not worth it!**
To install Sway on a Nvidia device, add the following to your archinstall config:

- **Profile:** Minimal
- **Additional Packages:** sway mesa xf86-video-nouveau libva-mesa-driver mesa-vdpau vulkan-icd-loader vulkan-nouveau
</details>

## Additional Setup

**yadm**

```bash
sudo pacman -S yadm
yadm clone https://github.com/Lil-Strudel/.dotfiles.git
yadm config local.class Strhuedel
```

Setup Firefox to get Bitwarden

```bash
yadm decrypt
```

Setup SSH for GitHub

```bash
yadm remote set-url origin git@github.com:Lil-Strudel/.dotfiles.git
```

**Separate working partition?**

Replace this with your user and the mount point of your partition

```bash
sudo chown strudel /strudel/
ln -s /strudel ~/strudel
```

**General OS Setup**

```bash
yay -S zoxide feh playerctl brightnessctl pavucontrol curl unzip eza ripgrep fzf openssh git
noto-fonts noto-fonts-cjk noto-fonts-emoji
```

<details>
<summary>I3 - Supporting Packages</summary>

// TODO: This

```bash
yay -S dunst
```

</details>
<details>
<summary>AwesomeWM - Supporting Packages</summary>

// TODO: This

</details>
<details>
<summary>Sway - Supporting Packages</summary>

// TODO: This

</details>
<details>
<summary>SSH</summary>

```bash
ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519.GitHub -C "${HOST} GitHub"
ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519.GitLab -C "${HOST} GitLab"
nvim ~/.ssh/config
```

```
Host github.com
    IdentityFile ~/.ssh/id_ed25519.GitHub

Host gitlab.com
    IdentityFile ~/.ssh/id_ed25519.GitLab
```

```bash
cat ~/.ssh/ied_ed25519.GitHub.pub
cat ~/.ssh/ied_ed25519.GitLab.pub
```

Copy the public keys into your respective Git providers

</details>
<details>
<summary>Yay</summary>

[Install yay from binary](https://github.com/Jguer/yay?tab=readme-ov-file#binary)

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin
```

</details>
<details>
<summary>Terminal</summary>

```bash
yay -S kitty zsh starship
```

Change the shell to zsh

```
chsh -s /bin/zsh
```

And [install Zap](https://github.com/zap-zsh/zap) to manage the zsh plugins

```
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
```

</details>

<details>
<summary>Firefox</summary>

```bash
yay -S firefox
```

- Open firefox
- Go to "about:profiles"
- Create a new profile
- Open browser in new profile
- Close browser in new profile
- Download (Right click -> `Save Link As...`) the [User.js File](https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js) into the new profiles directory
- Open browser in new profile
- Close all other tabs
- Delete original profiles
- Install Ublock Origin
- Install Bitwarden
- Go through Firefox settings and remove unwanted settings (Password manager, address auto fill, additional search engines, ect...)
</details>
<details>
<summary>Neovim</summary>

> Install Yarn before opening Neovim!

```bash
yay -S neovim xclip
```

Open Neovim.

</details>
<details>
<summary>Tmux</summary>

```bash
yay -S tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux
```

`Ctrl-B I`

</details>
<details>
<summary>Node</summary>

If you installed Zap with my ZSH config, FNM should already be installed on the system. If not install [FNM](https://github.com/Schniz/fnm)

```bash
fnm install --lts
fnm use *version that was installed*
fnm default *version that was installed*
npm i -g yarn
```

// TODO: Mason config

</details>
<details>
<summary>Go</summary>

```bash
yay -S go
```

// TODO: Mason config

</details>
<details>
<summary>Python</summary>

```bash
yay -S python-conda
```

// TODO: Mason config

</details>
<details>
<summary>MongoDB</summary>

```bash
yay -S mongodb-compass mongodb-tools
```

</details>
<details>
<summary>Docker</summary>

//TODO: This

</details>
<details>
<summary>GTK</summary>

```bash
yay -S rose-pine-gtk-theme-full lxappearance
```

- Open LxAppearance and set theme to Rose Pine
</details>
<details>
<summary>SDDM</summary>

// TODO: this

</details>
<details>
<summary>Terraform</summary>

```bash
yay -S terraform
terraform login
```

</details>
<details>
<summary>Thunar</summary>

```bash
yay -S thunar gvfs thunar-volman
```

- Launch Thunar
- Edit -> Preferences -> Advanced
- Check "Enable Volume Management" - Mount removable drives when hot-plugged - Mount removable media when inserted
</details>
<details>
<summary>Other Apps</summary>

```bash
yay -S slack-desktop spotify-launcher discord obsidian flameshot winbox
```

</details>
<details>
<summary>Keyring</summary>

```bash
yay -S gnome-keycring libsecret seahorse
```

</details>

### Congrats on your new setup!

## Windows 10 Setup Guide

1.  Boot into your Windows ISO
2.  Click "Install Now"
3.  Click "I don't have a product key"
4.  Click "Custom: Install Windows only (advanced)"
5.  Select the partition you made for Windows
6.  Click "Next"
7.  Wait.....

**Hi There! I’m Cortana, and I’m here to help. A little sign-in here, a touch of Wi-Fi there, and we’ll have your PC ready for all you plan to do.**

Despite it being insecure, I like to install Windows on an offline account. Windows only has my games so I don't really care if its not the most secure setup.

Once Windows is installed, update system and update Microsoft Store. Several times. Reboot, and update again. Thanks Windows for sucking.

[Install Chocolatey](https://chocolatey.org/install)

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Install apps [sophiapp](https://community.chocolatey.org/packages/sophiapp) and [Shutup10](https://community.chocolatey.org/packages/shutup10) using chocolatey.

```powershell
choco install sophiapp shutup10
```

Run [SophiApp](https://github.com/Sophia-Community/SophiApp) and completely clean Windows.

Run Shutup10 (Win+r and type OOSU10) and disable all the dumb stuff from Windows.

<details>
<summary>Tired of times being messed up every time you boot Windows?</summary>

Linux primarily works of UTC time. Windows doesn't. Run this command to fix that :)

```powershell
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f
```

</details>
