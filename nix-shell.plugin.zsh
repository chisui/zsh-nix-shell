
NIX_SHELL_PLUGIN_DIR=${0:a:h}

# extracts packages argument from args and passes them in $NIX_SHELL_PACKAGES variable.
function nix-shell() {
  local REAL_NIX_SHELL=${"$(type -p nix-shell)"#nix-shell\ is\ }
  local -a ARGS; ARGS=("$@")
  local NIX_SHELL_PACKAGES=""

  # extract -p|--packages argument into NIX_SHELL_PACKAGES
  local IN_PACKAGES=0
  while [[ ${#ARGS[@]} -gt 0 ]]
  do
    key=${ARGS[1]}
    # enter "--packages packages..." mode
    if [[ $key = "-p" || $key = "--packages" ]]
    then
      IN_PACKAGES=1
      NIX_SHELL_PACKAGES+=${ARGS[2]}
      ARGS=("${ARGS[@]:1}")

    # skip "--arg name value" argument
    elif [[ $key = "--arg" ]]
    then
      IN_PACKAGES=0
      ARGS=("${ARGS[@]:2}")

    # skip all other unary arguments 
    elif [[ $key == "-"* ]]
    then
      IN_PACKAGES=0
      ARGS=("${ARGS[@]:1}")

    # If we don't have any argument prefix we are either in package mode
    # or we have encountered the path argument
    elif [[ $IN_PACKAGES = 1 ]]
    then
      NIX_SHELL_PACKAGES+=" $key"
    fi
    ARGS=("${ARGS[@]:1}")
  done

  # call real nix shell
  env NIX_SHELL_PACKAGES="$NIX_SHELL_PACKAGES" \
      NIX_BUILD_SHELL="$NIX_SHELL_PLUGIN_DIR/scripts/buildShellShim.zsh" \
      $REAL_NIX_SHELL "$@"
}

