function gpmm -d 'merge main branch'
    set main (git_main_branch)
    git switch $main
    git pull
    git switch -
    git merge $main
end

