# Neovim Configuration

A modern, feature-rich Neovim configuration focused on development productivity.

## Features

- **LSP Support**: Full Language Server Protocol integration with Mason for automatic server management
- **Git Integration**: Comprehensive Git workflow with multiple plugins (Fugitive, Gitsigns, Neogit)
- **Advanced Editing**: Smart completion, snippets, and text manipulation tools
- **File Management**: Telescope fuzzy finder and NvimTree file explorer
- **UI Enhancements**: Modern statusline, themes, and visual improvements
- **Development Tools**: Integrated debugging, testing, and formatting support

## Quick Start

1. Clone this configuration:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

2. Install dependencies:
   ```bash
   nvim --headless "+Lazy! sync" +qa
   ```

3. Start Neovim and enjoy!

## Documentation

- **[Commands & Keymaps](docs/commands.md)** - Complete reference of all keyboard shortcuts and commands
- **Plugin Configuration** - Individual plugin configurations in `lua/plugins/active/`

## Key Features

### LSP & Completion
- Automatic language server installation via Mason
- Intelligent code completion with nvim-cmp
- Real-time diagnostics and error highlighting
- Code actions and refactoring support

### Git Workflow
- Visual git diff indicators in the gutter
- Comprehensive git interface with Neogit
- Git blame and history navigation
- Telescope integration for branch management

### File Management
- Fuzzy file finding with Telescope
- File tree navigation with NvimTree
- Quick file switching with Harpoon
- Recent files and project management

## Contributing

Feel free to fork and customize this configuration to your needs. The modular plugin structure makes it easy to add or remove features.

## License

This configuration is open source and available under the MIT License.