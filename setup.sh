#!/bin/bash

# save locations in variables
rootPath=$(pwd)/dotfiles
configPath=$HOME/.config

while getopts 'bglwop' flag; do
    case "$flag" in
            # base packages to install
        b ) packages="$packages $(cat packages)" ;;
            # gaming addons like steam, protonup-qt, ...
        g ) packages="$packages $(cat addonPackages/gaming)" ;;
            # laptop addons like autorandr
        l ) packages="$packages $(cat addonPackages/laptop)" ;;
            # work addons like programming language version mangers, API client, ...
        w ) packages="$packages $(cat addonPackages/work)" ;;
            # optional packages like anydesk, obs, ...
        o ) packages="$packages $(cat addonPackages/optional)" ;;
            # printer packages like cups, xsane, ...
        p ) packages="$packages $(cat addonPackages/printer)" ;;
    esac
done

if [ -n "$packages" ]; then
    echo "starting installation, this could take some time..."

    for package in $(cat packages); do
        yay -Qs $package 1>/dev/null 2>&1 || echo "installing: $package" && yay -S "$package" --noconfirm > /dev/null 2>&1
    done

    echo "install done"
else
    echo "no packages to install..."
fi

echo "root path is $rootPath"
echo "config path is $configPath"

read -p "Link dotfiles? [Y/n]" linkDotfilesChoice
case "$linkDotfilesChoice" in
    n|N ) echo "skipping..." ;;
    y|Y|* )
        # link all dotfiles from repo to .config
        #skip = ("redshift" "zsh" "git" "x11")
        for program in $(ls dotfiles); do
            #[[ "${skip[@]}" =~ $program ]] && continue
            echo "linking $program"
            if [ -e $configPath/$program ]; then
                # remove dir if it was already created
                rm -rf $configPath/$program
            fi
            # create symlink
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
        ;;
esac

echo "script is done"
