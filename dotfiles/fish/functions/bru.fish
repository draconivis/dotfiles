function bru -d 'update brew packages'
    brew update
    set outdated (brew outdated)
    echo $outdated

    if test -n "$outdated"
        read -l -P "upgrade packages? [Y/n] " ans
        switch $ans
            case N n
                # Do nothing
            case Y y ''
                brew upgrade
        end
    end
end

