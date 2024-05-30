# zsh

## setup

### [antigen](https://github.com/zsh-users/antigen)

1. install antigen
  ```sh
  curl -L git.io/antigen > ${HOME}/.config/zsh/antigen.zsh
  ```
2. link the correct [.zshrc](/configs/dotfiles/zsh/zshrc-antigen)
  ```sh
  ln -s ${HOME}/.config/zsh/zshrc-antigen ${HOME}/.zshrc
  ```
3. restart zsh
  open a new zsh instance and antigen will automatically install the plugins
