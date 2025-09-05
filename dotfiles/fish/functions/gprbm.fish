function gprbm -d 'rebase on main branch'
    set main (git_main_branch)
    git switch $main
    git pull
    git switch -
    git rebase $main
end

