# enable this to switch dirs when exiting lazygit
# function lg()
# {
#     export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
#
#     lazygit "$@"
#
#     if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
#             cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
#             rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
#     fi
# }

function gprbm()
{
  git switch $(git_main_branch)
  git pull
  git switch -
  git rebase $(git_main_branch)
}

function gpmm()
{
  git switch $(git_main_branch)
  git pull
  git switch -
  git merge $(git_main_branch)
}

function phpsw () {
  brew unlink php@$1
  brew link --overwrite --force shivammathur/php/php@$1
}
