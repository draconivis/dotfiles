fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-davidde-SLASH-git )
source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-davidde-SLASH-git/git.plugin.zsh
fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-marlonrichert-SLASH-zsh-autocomplete )
source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-marlonrichert-SLASH-zsh-autocomplete/zsh-autocomplete.plugin.zsh
fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting )
source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer )
  source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions )
zsh-defer source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search )
source /home/patrick/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
