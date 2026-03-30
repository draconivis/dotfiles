function grbm --description "Rebase current branch onto repo default branch"
    set default (git rev-parse --abbrev-ref origin/HEAD)
    if test $status -ne 0
        echo "Could not determine default branch from origin/HEAD" >&2
        return 1
    end

    # strip leading 'origin/' to get the branch name
    set default_branch (string replace -r '^origin/' '' $default)

    git fetch origin
    git rebase origin/$default_branch
end

