# ─── CONFIGURATION ──────────────────────────────────────────────────────────────
user_name="your_name"  #
shell_icon="􀟛"   # can be SF Symbols
dir_divider="/"  #
dash_char="-"    #
prompt_icon="#"  #

# Colors (ANSI escape sequences; e.g. $'\033[38;5;104m' or standard codes)
icon_color=$'\033[38;5;67m'
name_color=$'\033[38;5;104m'
divider_color=$'\033[38;5;61m'
dir_color=$'\033[38;5;61m'
dash_color=$'\033[38;5;241m'
hash_color=$'\033[37m'
reset_color=$'\033[0m'

# ─── END CONFIGURATION ──────────────────────────────────────────────────────────

print_welcome() {
  local welcome=" - Welcome back, ${user_name}! -"
  local cols=$(tput cols)
  local pad=$(( cols - ${#welcome} ))
  (( pad < 0 )) && pad=0
  printf "%s" "$welcome"
  for ((i=0; i<pad; i++)); do
    printf "%s" "-"
  done
  printf "\n"
}

print_welcome

TRAPWINCH() {
  print -Pn "\e[1;1H"
  print -Pn "\e[0K"
  print_welcome
  zle reset-prompt
}
escape_for_prompt() {
  local s="$1"
  echo "${s//%/%%}"
}

# ─── PROMPT BUILD ────────────────────────────────────────────────────────────────
ICON="%{${icon_color}%} ${shell_icon} %{${reset_color}%}"
DASH="%{${dash_color}%} ${dash_char} %{${reset_color}%}"
USER_NAME="%{${name_color}%}${user_name}%{${reset_color}%}"

ESC_ICON=$(escape_for_prompt "$shell_icon")
ESC_DIV=$(escape_for_prompt "$dir_divider")
ESC_DASH=$(escape_for_prompt "$dash_char")
ESC_PROMPT_ICON=$(escape_for_prompt "$prompt_icon")

if [[ "${show_dir}" == true ]]; then
  DIR_SEG="%{${divider_color}%}${ESC_DIV}%{${reset_color}%}%{${dir_color}%}%1~%{${reset_color}%}"
else
  DIR_SEG=""
fi

PROMPT_SYMBOL="%{${hash_color}%}${ESC_PROMPT_ICON} %{${reset_color}%}"

PROMPT="${ICON}${DASH}${USER_NAME}${DIR_SEG} ${PROMPT_SYMBOL}"
# ─── END ─────────────────────────────────────────────────────────────────────────
