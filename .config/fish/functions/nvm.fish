#
# wrapper for Node Version Manager
#
# https://github.com/creationix/nvm
# https://github.com/edc/bass#nvm

function nvm --description='Node enVironment Manager'
    bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end
