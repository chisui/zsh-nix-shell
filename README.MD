
# zsh in nix-shell

This [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) plugin lets you use zsh as the default shell in a `nix-shell` environment. It's recommended to use this in conjunction with [nix-zsh-completions](https://github.com/spwhitt/nix-zsh-completions).

In theory all you have to do to get this behavior is set `NIX_BUILD_SHELL` to zsh. Unfortunatly nix assumes that the `NIX_BUILD_SHELL` is a bash variant and passes bash specific arguments to the shell. So we need a shim to be able to process these arguments.

If you use the `--run` argument to execute something inside the `nix-shell` and then return it will still be run using bash since we only need zsh for interactive shells.

Additionally this plugin passes what packages are specified to the shell in `NIX_SHELL_PACKAGES`. The main purpose for this is so that they may be printed in the promt. Take a look at this [variant of the agnoster theme](https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e#file-agnoster-nix-zsh-theme) for an example of how this might look.

![example prompt](https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/8787d8e234e895b2c74194936290a0da9be539ff/example.png)

# Installation

## Oh-My-ZSH

    git clone git@github.com:chisui/zsh-nix-shell.git ~/.oh-my-zsh/custom/plugins/nix-shell

Then add `nix-shell` to the plugins list in `~/.zshrc`.

## Plain ZSH

Clone this repository and add the following to your `~/.zshrc`.

    source /path/to/zsh-nix-shell/nix-shell.plugin.zsh

