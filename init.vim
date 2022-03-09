" == Use ~/.config/nvim/lua/config.lua ==
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
lua require('config')
