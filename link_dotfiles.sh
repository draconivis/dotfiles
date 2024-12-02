#!/usr/bin/env bash

# save locations in variables
rootPath=$(pwd)/dotfiles
configPath=$HOME/.config
gumAvailable=false
if command -v gum &>/dev/null; then
    gumAvailable=true
# TODO: add conditions to print with echo if gum isn't available!
fi

gum style \
	--border-foreground 57 --border double \
	--align center --width 100 --margin "1 2" --padding "2 4" \
	'Dotfiles setup' '' "Root path is $rootPath" "Config path is $configPath"

gum confirm || exit 1

clear

# gum spin doesn't work here :c
gum style \
	--border-foreground 57 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Linking Files...'

for program in $(ls dotfiles); do
    if [ -e $configPath/$program ]; then
        rm -rf $configPath/$program
    elif [ -L $configPath/$program ]; then
        rm $configPath/$program
    fi
    ln -s $rootPath/$program $configPath/
done

# link files that need to exist in a different place than .config
# zshrc and p10k-config to ~
[[ -e $HOME/.zshrc || -L $HOME/.zshrc ]] && rm $HOME/.zshrc
ln -s $configPath/zsh/zshrc $HOME/.zshrc
[[ -e $HOME/.p10k.zsh || -L $HOME/.p10k.zsh ]] && rm $HOME/.p10k.zsh
ln -s $configPath/zsh/p10k.zsh $HOME/.p10k.zsh
# redshift to .config root
[[ -e $configPath/redshift.conf || -L $configPath/redshift.conf ]] && rm $configPath/redshift.conf
ln -s $rootPath/redshift/redshift.conf $configPath/
# gitconfig to ~
[[ -e $HOME/.gitconfig || -L $HOME/.gitconfig ]] && rm $HOME/.gitconfig
ln -s $rootPath/git/gitconfig $HOME/.gitconfig
# x11 config files to ~
for file in $(ls dotfiles/x11); do
    [[ -e $HOME/.$file || -L $HOME/.$file ]] && rm $HOME/.$file
    ln -s $configPath/x11/$file $HOME/.$file
done

gum style \
	--border-foreground 57 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Done!'
