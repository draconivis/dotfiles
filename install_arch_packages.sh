#!bash

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

