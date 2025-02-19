# Neovim Config

Here's an outline of my neovim configuration

```bash
.
├── README.md       # <- YOU ARE HERE
├── init.lua        # Sets up everything in `lua/plugins/`
├── lazy-lock.json  # Lockfile, NEVER edit manually
└── lua             # Directory for lua stuffs, just plugins at the moment
    ├── plugins     # Self explanatory
    │   ├── automaton.lua    # For fun
    │   ├── comment.lua      # For easy commenting in code
    │   ├── completions.lua  # For nice looking and easy completions
    │   ├── conform.lua      # For format on save
    │   ├── distant.lua      # For ssh editing
    │   ├── flash.lua        # For jumping to marks within a file
    │   ├── harpoon.lua      # For ThePrimeagen 🙏
    │   ├── lsp.lua          # For language servers
    │   ├── statusline.lua   # For swag
    │   ├── telescope.lua    # For pretty pop-up windows
    │   ├── theme.lua        # For Gruvbox, the 🐐
    │   ├── transparent.lua  # For transparent backgrounds, so I can copy code easier
    │   ├── treesitter.lua   # For code
    │   ├── webdevicons.lua  # For code
    │   └── whichkey.lua     # For reminding me to actually use the keybinds I wrote
    ├── plugins.lua  # Sets up plugins
    └── vimopts.lua  # All my random vim options and mappings
```

## Checking on updates

To check on LSPs, use 

```bash
:Mason
```

To check on treesitter, use

```bash
:TSUpdate
```

To check on Lazy, use

```bash
:Lazy
```

## Debugging

Make use of

```bash
:checkhealth
```

for Neovim bugs that pop-up (may occur after updates).

Be sure to check on

```bash
:LspInfo
```

for any language server weirdness that may pop-up.
