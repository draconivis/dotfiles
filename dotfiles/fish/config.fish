set -g fish_greeting
set FISH_HOME $HOME/.config/fish
fish_add_path /opt/homebrew/bin

if test -f (brew --prefix)/etc/brew-wrap.fish
  source (brew --prefix)/etc/brew-wrap.fish
end

oh-my-posh init fish --config $FISH_HOME/omp.toml | source
zoxide init --cmd cd fish | source
