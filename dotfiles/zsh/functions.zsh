#vagrant
function vup () {
  cd ~/work/start/homestead
  vagrant up
  cd -
}
function vdown () {
  cd ~/work/start/homestead
  vagrant suspend
  cd -
}
function vssh () {
  cd ~/work/start/homestead
  vagrant ssh
  cd -
}
function vhalt () {
  cd ~/work/start/homestead
  vagrant halt
  cd -
}

function snapshot-mover() {
  cp -r ./* ~/work/coupon-frontend-react/packages/coupon-frontend-react-"$1"/cypress/snapshots/base/pages/;

  cd ~/work/coupon-frontend-react/packages/coupon-frontend-react-"$1"/cypress/snapshots/base/pages/ || exit;

  find . -depth -name "*-base.png" -delete;
  find . -depth -name "*-actual.png" | rename 's/actual/base/';

  echo "success!";
}

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
