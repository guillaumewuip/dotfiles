bleopt highlight_syntax=

bleopt highlight_filename=

bleopt highlight_variable=

bleopt complete_auto_complete=

bleopt complete_auto_history=

bleopt complete_ambiguous=

bleopt prompt_eol_mark=''

bleopt exec_errexit_mark=$'\e[91m[error %d]\e[m'

bleopt exec_elapsed_mark=

bleopt exec_exit_mark=

bleopt edit_marker=
bleopt edit_marker_error=

# Reset title to "dir" when back at prompt
bleopt prompt_xterm_title='\w'

function blerc/vim-mode-hook {
	bleopt keymap_vi_mode_show=
}

blehook/eval-after-load keymap_vi blerc/vim-mode-hook

# # Set title to "cmd - dir" when a command is running
# blehook PREEXEC+='_ble_set_title_for_cmd'
#
# function _ble_set_title_for_cmd {
# 	local cmd dir
# 	# Get just the command name (first word), strip path prefix
# 	cmd="${BASH_COMMAND%%[[:space:]]*}"
# 	cmd="${cmd##*/}"
# 	dir="${PWD/#$HOME/\~}" # replace $HOME with ~
# 	builtin printf '\033]0;%s - %s\007' "$cmd" "$dir" >/dev/tty
# }
