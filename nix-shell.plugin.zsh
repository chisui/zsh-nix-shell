export NIX_BUILD_SHELL="$(dirname $0)/scripts/buildShellShim.zsh"

# extracts packages argument from args and passes them in $NIX_SHELL_PACKAGES variable.
function nix-shell() {
  local REAL_NIX_SHELL=$(whereis -b nix-shell | sed -e "s/^nix-shell: //")
  local ARGS=( "$@" )
  local NIX_SHELL_PACKAGES=""

  local IN_PACKAGES=0
  while [[ ${#ARGS[@]} -gt 0 ]]
  do
    key=${ARGS[1]}
    if [[ $key = "-p" || $key = "--packages" ]]; then
      IN_PACKAGES=1
      NIX_SHELL_PACKAGES+=${ARGS[2]}
      ARGS=("${ARGS[@]:1}")
    elif [[ $key  == "-"* ]]; then
      IN_PACKAGES=0
    elif [[ $IN_PACKAGES = 1 ]]; then
      NIX_SHELL_PACKAGES+=" $key"
    fi
    ARGS=("${ARGS[@]:1}")
  done
  env NIX_SHELL_PACKAGES="$NIX_SHELL_PACKAGES" $REAL_NIX_SHELL "$@"
}

