
# zsh in nix-shell

This [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) plugin lets you use zsh as the default shell in a `nix-shell` environment. It's recommended to use this in conjunction with [nix-zsh-completions](https://github.com/spwhitt/nix-zsh-completions).

# Motivation

In theory all you have to do to get this behavior is set `NIX_BUILD_SHELL` to zsh. Unfortunatly nix assumes that the `NIX_BUILD_SHELL` is a bash variant and passes bash specific arguments to the shell. So we need a shim to be able to process these arguments.

We may also want to include information about the current nix-shell environment in the prompt. Currently `nix-shell` only provides the `IN_NIX_SHELL` environment variable that indicates that you are currently inside a nix shell environment. More granular information would be nice.

# Usage

Use `nix-shell` as you did before.

If you use the `--run` or `--command` argument to execute something inside the `nix-shell` and then return it will still be run using bash. In the case of `--command` the interactive shell will still be `zsh`.

## passed arguments

This plugin passes certain arguments of `nix-shell` as environment variables to the spawned shell:

Argument      | Variable              | Notes
------------- | --------------------- | -----
`packages...` | `NIX_SHELL_PACKAGES`  | Passed unaltered.
`path`        | `NiX_SHELL_FILE_PATH` | If `-p\|--packages` is not used this Variable will always be present. The current working directory is always prepended to the variable. It also searches for any `shell.nix` or `default.nix` files if the `path` is a directory.

These variables can be used inside a theme to customize. Take a look at this [variant of the agnoster theme](https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e#file-agnoster-nix-zsh-theme) for an example of how this might look.

![example prompt](https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/8787d8e234e895b2c74194936290a0da9be539ff/example.png)

![example prompt for projects](https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/9e2981bba3f0695e4705f3ea38cea0a239e5fb7d/exampleProject.png)

# Installation

## Oh-My-ZSH

    git clone git@github.com:chisui/zsh-nix-shell.git $ZSH_CUSTOM/plugins/nix-shell

Then add `nix-shell` to the plugins list in `~/.zshrc`.

## Plain ZSH

Clone this repository and add the following to your `~/.zshrc`.

    source /path/to/zsh-nix-shell/nix-shell.plugin.zsh

# Contributing

Please do. Pull requests welcome.

