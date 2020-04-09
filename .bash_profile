if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# ---------- PATH --------------

# The PATH variable starts with the contents of /etc/paths and then has the contents of files in /etc/path.d/ appended

# Anaconda3 
# > Contents within this block are managed by 'conda init'
__CONDA_HOME="${CONDA_HOME}/Programs/anaconda3"
__conda_setup="$(CONDA_REPORT_ERRORS=false "${CONDA_HOME}/bin/conda" shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "${CONDA_HOME}/etc/profile.d/conda.sh" ]; then
        . "${CONDA_HOME}/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        PATH="$PATH:${CONDA_HOME}/bin"
    fi
fi
unset __conda_setup __CONDA_HOME

if [[ -z $TMUX ]]
then
	# Cargo
	PATH="$PATH:$HOME/.cargo/bin"

	# NPM
	# > Check here first before checking /usr/local/bin/ for npm, to add globals to a local directory (for ease with permissions).
	PATH="$PATH:$HOME/.node_modules_global/bin"  

	# XAMPP - Handy shortcut.
	#PATH="/Users/Alex/.bitnami/stackman/machines/xampp/volumes/root/project:$PATH"

	export PATH
fi

# -----------------------------

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export CLICOLOR=1
export TERM=xterm-256color

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
