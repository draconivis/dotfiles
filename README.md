# dotfiles

dotfiles & setup instructions

## linux

### packages

the main packages i use everywhere are in [packages](./packages).
additional packages can be found in [addonPackages](./addonPackages).

### setup

#### packages

to install the packages, run [`install_arch_packages.sh`](./install_arch_packages.sh) on an arch install.

the script accepts some options, these are:

- b > base packages
- g > gaming related packages
- l > laptop related packages
- w > work related packages
- o > optional packages
- p > printing packages

e.g to install the base and laptop packages, run

```sh
./install_arch_packages.sh -b -l
```

it will then install the packages (sudo password may be required)

#### dotfiles

to link the dotfiles, run [`link_dotfiles.sh`](./link_dotfiles.sh).

NOTE: It requires you to have [gum](https://github.com/charmbracelet/gum) installed

it will create symlinks from this repo to .config and some other places.

additional info on the dotfiles can be found in their respective READMEs.

### various software stuff / fixes / configs

#### keyboard

##### repetition settings

- repeat delay: 175
- repeat speed: 100
- keyboard layout: eu (EurKey)

put this in `/etc/X11/xorg.conf.d/00-keyboard.conf`:

```
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "eu"
        Option "AutoRepeat" "175 10"
EndSection
```

notice that in the AutoRepeat line i put 10 instead of 100 because the unit here is Hz, so lower number = more repitions, see [here](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#Using_AutoRepeat_configuration_option)

##### caps remap

if you used my base packages, then `interception-caps2esc` is already installed, else install that.

edit `/etc/interception/udevmon.yaml` and add [the JOB from the README](https://gitlab.com/interception/linux/plugins/caps2esc#execution)

then start the daemon with `sudo systemctl enable --now udevmon.service`

#### firefox adjustments

##### don't exit when closing last tab

open `about:config`, search `closeWindowWithLastTab` and toggle to `false`

##### invert scroll direction + increased scroll height

if for some reason the DE/WM setting (~/.Xmodmap) doesn't apply, open `about:config` and search for `mousewheel.default.delta_multiplier_y` and set it to a negative number.
negative for the scroll direction and the higher the number, the more lines you scroll.

#### system beep - autostart

to turn that annoying system beep off, you can:

- run `rmmod pcspkr`
- add `blacklist pcspkr` to `/etc/modprobe.d/nobeep.conf`
- run `xset b off`
- uncomment `set bell none` in `/etc/inputrc`

#### printing / scanning

**install packages with `setup.sh -p`**

for my hp printer, there are following things i installed for printing / scanning

- hplip - drivers for hp printer
- sane & xsane - access to the scanner & gui for it

the printer settings should detect the printer and it should be fairly easy to set up.
if you open xsane, it should automatically detect the scanner, but you can also run `hp-setup` to set up the printer.

#### [Pulseaudio muting things](https://forum.teamspeak.com/threads/135702-Ubuntu-Teamspeak-mutet-andere-Anwendungen?p=457097#post457097)

After i joined a Teamspeak channel, Spotify suddenly stopped playing and i couldn't get it back to work. Then i found out, that the cork-module is loaded by default, which mutes other applications based on roles (teamspeak was phone so it muted the others to prevent missing the phone call)

#### [enabling nvidia overclocking](https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Enabling_overclocking)

there's also [GreenWithEnvy](https://github.com/dankamongmen/GreenWithEnvy) but it reqquires a more involved setup and didn't work for me

#### [focusrite scarlet solo](https://thanede.wordpress.com/2017/07/03/getting-a-focusrite-scarlett-solo-to-work-under-linux-common-issues/)

some things to fix the scarlet solo on liux (like disabling the usb power optimization)

UPD@20.04.23: i reinstalled endeavour and the interface is not turning off anymore...

#### [webp support in ristrettro](https://www.reddit.com/r/xfce/comments/v1tbp4/set_default_application_to_open_imagewebp_files/iaoi06c/)

**in [default package list](./packages)**

ristretto doesn't support webp by default, the package `webp-pixbuf-loader` adds that

## mac

### various software stuff / fixes / configs

#### keyboard setup

run

```
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
```

and log out / in or restart to apply changes

[website to test settings](https://mac-key-repeat.zaymon.dev/)

#### shortcut to drag window

to enable dragging a window with a shortcut (just like on linux), run

```
defaults write -g NSWindowShouldDragOnGesture -bool true
```

to disable

```
defaults delete -g NSWindowShouldDragOnGesture
```

#### nvm install

To install node versions older than 16 on a m-chip mac, refer to the nvm readme: [MacOS Troubleshooting -> Macs with Apple Silicon chips](https://github.com/nvm-sh/nvm?tab=readme-ov-file#macos-troubleshooting),

### apps

some apps that aren't installed with brew:

- [autoraise](https://github.com/sbmpost/AutoRaise)

## git

some gitconfig that you'd probably want to use:

```
# if you use git-delta
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true    # use n and N to move between diff sections

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default

[push]
    autoSetupRemote = true

[init]
    defaultBranch = main

[rerere]
    enabled = true
```

# alternatives

here are some alternatives to linux commands that may be better

### [btop](https://github.com/aristocratos/btop)

displays computer resources; replaces `htop`

### [bat](https://github.com/sharkdp/bat)

replaces cat; has nicer output, but prints line numbers, so not as good for content copying / piping

### [delta](https://github.com/dandavison/delta)

can replace default diff viewer; i use it for a better `git diff`

### [broot](https://github.com/canop/broot)

for viewing directories in a tree structure; instead of `tree`

### [lsd](https://github.com/peltoche/lsd)

for listing files. is using icons and has more color; instead of `ls`

### [dust](https://github.com/bootandy/dust)

for viewing directory sizes, instead of `du`

### [tldr](https://github.com/tldr-pages/tldr)

get a short 'cheatsheet' for commands

alternatively just use `curl cheat.sh`, like

```sh
curl cheat.sh/autorandr
```
