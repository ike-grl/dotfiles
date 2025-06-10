# dotfiles
Ike's dotfiles. 

## Getting started

```sh
# clone to ~/.dotfiles repo
git clone https://github.com/quantike/dotfiles ~/.dotfiles
```

Then run the bootstrap script, which will need to be run more than once because I suck at bash.

```sh
sh bootstrap.sh
```

> Keep an eye out for input prompts

## Setting up Neovim

```sh
sh bootstrap-nvim.sh
```

Then when you first run `nvim` it should bootstrap lazy.nvim install and set up everything.

## TODO List

- [x] AWS Account switching
- [x] AWS Account shell prompt
- [ ] Direnv config not tracked
- [ ] Make AWS Account shell prompt prettier