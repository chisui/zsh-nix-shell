
# zsh in nix-shell

This [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) plugin lets you use zsh as the default shell in a `nix-shell` environment. It's recommended to use this in conjunction with [nix-zsh-completions](https://github.com/spwhitt/nix-zsh-completions).

# Motivation

In theory all you need to do to use `zsh` in `nix-shell` is to set `NIX_BUILD_SHELL` to `zsh`. Unfortunatly nix assumes that the `NIX_BUILD_SHELL` is a bash variant and passes bash specific arguments to the shell. To fix this, we need a shim that translates these arguments.

The information that `nix-shell` exposes to the environment is also pretty sparse. It would be nice to know what derivations are included in the current environment for example to display them in the shells prompt. 

# Installation

## Oh-My-ZSH

Clone this repository into your plugins directory

```sh
git clone https://github.com/chisui/zsh-nix-shell.git $ZSH_CUSTOM/plugins/nix-shell
```

Then add `nix-shell` to the plugins list in `~/.zshrc`.

### NixOS

If you have installed `zsh` using `nix` the plugins directory is readonly since it's inside of the nix store.
To get around this you can override the [`ZSH_CUSTOM` directory](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#using-another-customization-directory).
Simply create a writable directory inside of your home directory (e.g. `$HOME/.config/oh-my-zsh`) and set `ZSH_CUSTOM` to that path inside of your `.zshrc` file.

```sh
ZSH_CUSTOM=$HOME/.config/oh-my-zsh
```

After that simply install for `oh-my-zsh` as normal.

## Plain ZSH

Clone this repository and add the following to your `~/.zshrc`.

```sh
source /path/to/zsh-nix-shell/nix-shell.plugin.zsh
```

## home-manager

Add this repository to the [`plugins` list of your configurations](https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.plugins):

```nix
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
        };
      }
    ];
  };
}
```

## Plugin managers

It should be possible to install this plugin through most `zsh` plugin managers. If the one of your choice is not supported, feel free to open an issue or even better create a pull request.

## MacOS

On MacOS you have to have a `bash` with version `4` or greater. [See Issue 14](https://github.com/chisui/zsh-nix-shell/issues/14)

# Usage

Use `nix-shell` as you did before.

Commands run with `--run` or `--command` argument are executed in `nix-shell`s default shell. In the case of `--command` you are put into a `zsh` shell afterwards.

## `--pure`

If you use the `--pure` flag the interactive shell will be the default shell.

## Environment info

If you are inside a `nix-shell` environment `IN_NIX_SHELL` will be set. The value will be `impure` or `pure` if you specified `--pure`.

The `packages` argument is passed through as `NIX_SHELL_PACKAGES` to the shell. 

If this Variable is empty `nix-shell` was called for a specific nix expression which is stored in the `name` environment variable.

These variables can now be used inside a theme to customize the prompt. Take a look at this [variant of the agnoster theme](https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e#file-agnoster-nix-zsh-theme) for an example of how this might look.

![example prompt](https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/8787d8e234e895b2c74194936290a0da9be539ff/example.png)

![example prompt for projects](https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/ea75cad507e2899b9b6d6ce423330641911110d8/exampleProject.png)

# Limitations

## Shell hooks

Shell hooks are supported in general. Since they are executed inside of `bash` before the `zsh` shell is spawned they aren't executed in the same environment. This means that things like aliases won't work.

## Zsh dotfiles

The normal zsh dotfiles are sourced after the nix-shell is opened. This means that you have to take into account that these files may override variables set by nix-shell.

# Contributing

Please do. Pull requests welcome.
