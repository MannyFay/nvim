# Commands & Keymaps Reference

This document contains all keyboard shortcuts and commands available in this Neovim configuration.

## Git Commands

### Basic Git Operations

| Keymap | Plugin | Command | Description |
|--------|--------|---------|-------------|
| `<leader>gs` | neogit | `:Neogit` | Open Git status buffer |
| `<leader>gc` | neogit | `:Neogit commit` | Open Git commit buffer |
| `<leader>gp` | neogit | `:Neogit push` | Open Git push buffer |
| `<leader>gP` | neogit | `:Neogit pull` | Open Git pull buffer |
| `<leader>gb` | fugitive | `:Git blame` | Open Git blame window |

### Git Navigation & Information

| Keymap | Plugin | Command | Description |
|--------|--------|---------|-------------|
| `<leader>gB` | telescope | `:Telescope git_branches` | Browse Git branches |
| `<leader>gh` | gitsigns | `:Gitsigns preview_hunk` | Preview current hunk |
| `<leader>glb` | gitsigns | `:Gitsigns toggle_current_line_blame` | Toggle line blame info |

### Git Signs (Gutter Indicators)

Git changes are automatically shown in the sign column with these indicators:

| Symbol | Meaning |
|--------|---------|
| `▎` | Added lines |
| `▎` | Changed lines |
| ` ` | Deleted lines |
| `┆` | Untracked files |

### Additional Fugitive Commands

Use `:Git <command>` for any git command. For example:
- `:Git status`
- `:Git log`
- `:Git diff`
- `:Git add .`
- `:Git commit -m "message"`

## Telescope Commands

| Keymap | Plugin | Command | Description |
|--------|--------|---------|-------------|
| `<leader>u` | telescope-undo | `:Telescope undo` | Browse undo history |

## LSP Commands

*Coming soon...*

## File Management Commands

*Coming soon...*

## Editor Commands

*Coming soon...*

---

**Note**: `<leader>` is typically mapped to the space key (` `) in this configuration.