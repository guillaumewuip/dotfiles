#!/usr/bin/env bash
# Prompt Configuration File
# Combines git status, worktree detection, and prompt building functions
# Only loads when not in VS Code terminal
# Sets up PROMPT_COMMAND to dynamically update the shell prompt

# Skip loading in VS Code terminal
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
	return 0
fi

# Color codes (using \001 and \002 for bash readline non-printing character markers)
# These are equivalent to \[ and \] but work properly in command substitution
readonly YELLOW_BOLD=$'\001\033[1;33m\002'
readonly ORANGE_BOLD=$'\001\033[1;35m\002'
readonly RED_BOLD=$'\001\033[1;31m\002'
readonly PURPLE_BOLD=$'\001\033[1;34m\002'
readonly RESET=$'\001\033[0m\002'

# ============================================================================
# Git Status Functions
# ============================================================================
# Parse git status and format for prompt display
# Uses git status --porcelain=v2 --branch for reliable, fast parsing

git_status_format() {
	# Single git call: confirms we're in a repo AND gets all status info
	local status_output
	status_output=$(git status --porcelain=v2 --branch 2>/dev/null) || return 1

	local branch_name="" ahead=0 behind=0 is_detached=false
	local untracked=0 modified=0 staged=0 deleted=0 renamed=0 stashed=0

	while IFS= read -r line; do
		case "$line" in
		"# branch.head "*)
			local head_value="${line#*branch.head }"
			if [[ "$head_value" != "HEAD" && "$head_value" != "(detached)" ]]; then
				branch_name="$head_value"
				is_detached=false
			fi
			;;
		"# branch.oid "*)
			if [[ -z "$branch_name" ]] || [[ "$is_detached" == true ]]; then
				is_detached=true
				branch_name="${line#*branch.oid }"
				branch_name="${branch_name:0:7}"
			fi
			;;
		"# branch.ab "*)
			# Parse ahead/behind with bash string ops (no awk/sed)
			local ab_info="${line#*branch.ab }"
			local ahead_str="${ab_info%% *}"  # "+X"
			local behind_str="${ab_info##* }" # "-Y"
			ahead="${ahead_str#\+}"
			behind="${behind_str#-}"
			;;
		"1 "* | "2 "*)
			# Extract XY field with bash string ops (no awk subshell)
			local rest="${line#* }"       # strip leading "1 " or "2 "
			local xy_status="${rest%% *}" # first word is XY

			case "${xy_status:0:1}" in
			"M" | "A" | "R" | "C" | "T") ((staged++)) ;;
			"D") ((deleted++)) ;;
			esac

			case "${xy_status:1:1}" in
			"M" | "T") ((modified++)) ;;
			"D") ((deleted++)) ;;
			esac

			if [[ "$xy_status" == R* ]] || [[ "$xy_status" == *R ]]; then
				((renamed++))
			fi
			;;
		"? "*)
			# Untracked files are in porcelain v2 output — no extra git call needed
			((untracked++))
			;;
		"u "*)
			((modified++))
			;;
		esac
	done <<<"$status_output"

	# Stash: fast single ref check instead of git stash list | wc -l
	git rev-parse --verify refs/stash >/dev/null 2>&1 && stashed=1

	local output=""
	output+=" "
	if [[ "$is_detached" == true ]]; then
		output+="(detached: $branch_name)"
	else
		output+="$branch_name"
	fi

	local indicators=""
	if [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]; then
		indicators+="⇕"
	elif [[ $ahead -gt 0 ]]; then
		indicators+="${ahead}⇡"
	elif [[ $behind -gt 0 ]]; then
		indicators+="${behind}⇣"
	fi

	[[ $untracked -gt 0 ]] && indicators+="${indicators:+ }u"
	[[ $stashed -gt 0 ]] && indicators+="${indicators:+ }\$"
	[[ $modified -gt 0 ]] && indicators+="${indicators:+ }m"
	[[ $staged -gt 0 ]] && indicators+="${indicators:+ }s"
	[[ $renamed -gt 0 ]] && indicators+="${indicators:+ }r"
	[[ $deleted -gt 0 ]] && indicators+="${indicators:+ }d"

	[[ -n "$indicators" ]] && output+=" ($indicators)"

	echo "$output"
}

# Build the prompt
build_prompt() {
	local ps1=""

	# --- Directory: inlined (no subshell) ---
	local dir="$PWD"
	[[ "$dir" == "$HOME"* ]] && dir="~${dir#$HOME}"
	local _IFS="$IFS"
	IFS='/'
	local -a _parts=($dir)
	IFS="$_IFS"
	local _count=${#_parts[@]}
	if [[ $_count -gt 5 ]]; then
		dir=""
		for ((i = _count - 5; i < _count; i++)); do dir+="/${_parts[i]}"; done
		dir="...$dir"
	fi
	ps1+="${YELLOW_BOLD}${dir}${RESET} "

	# --- Git: one call covers repo check, status, and all indicators ---
	local git_info
	git_info=$(git_status_format 2>/dev/null)
	if [[ $? -eq 0 && -n "$git_info" ]]; then
		# Worktree detection: 2 fast git calls, only reached when inside a repo
		local gd gcd
		gd=$(git rev-parse --git-dir 2>/dev/null)
		gcd=$(git rev-parse --git-common-dir 2>/dev/null)
		if [[ "$gd" != "$gcd" ]]; then
			local _root
			_root=$(dirname "$gcd")
			ps1+="${PURPLE_BOLD}($(basename "$_root"))${RESET} "
		fi

		# Apply colors to git info
		if [[ "$git_info" == *"("* ]]; then
			ps1+="${ORANGE_BOLD}${git_info%%(*}${RESET}${RED_BOLD}(${git_info#*\(}${RESET} "
		else
			ps1+="${ORANGE_BOLD}${git_info}${RESET} "
		fi
	fi

	# --- Jobs: bash builtin, no subprocess ---
	local -a _jobs
	mapfile -t _jobs < <(jobs -p 2>/dev/null)
	[[ ${#_jobs[@]} -gt 0 ]] && ps1+=" ${#_jobs[@]}"

	ps1+=$'\n '
	echo -n "$ps1"
}

# ============================================================================
export -f git_status_format
export -f build_prompt

__current_command=""

# update terminal window to be <command> - <current directory>
function preexec() {
	# Extract command name (first word)
	__current_command="${1%% *}"
	builtin printf '\033]0;%s - %s\007' "${__current_command}" "${PWD/#$HOME/\~}"
}

PS1='$(build_prompt)'
