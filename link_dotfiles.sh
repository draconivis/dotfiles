#!bash

# save locations in variables
rootPath=$(pwd)/dotfiles
configPath=$HOME/.config

echo "root path is $rootPath"
echo "config path is $configPath"

read -p "Link dotfiles from $rootPath -> $configPath? [Y/n]" linkDotfilesChoice
case "$linkDotfilesChoice" in
    n|N ) echo "skipping..." ;;
    y|Y|* )
        # link all dotfiles from repo to .config
        for program in $(ls dotfiles); do
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
