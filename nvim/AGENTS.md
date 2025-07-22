# AGENTS.md

## Build, Lint, and Test Commands

- **Build**: No specific build command is defined. Ensure all plugins and configurations are correctly set up in `init.lua`.
- **Lint**: Use `luacheck` for linting Lua files. Example: `luacheck lua/`.
- **Test**: No specific test framework is defined. Consider using `busted` for Lua testing.
- **Run a Single Test**: If using `busted`, run a single test with `busted --filter="test_name"`.

## Code Style Guidelines

- **Imports**: Use `require` to import modules. Organize imports at the top of the file.
- **Formatting**: Follow the default Lua style. Use 4 spaces for indentation.
- **Types**: Lua is dynamically typed. Use comments to indicate expected types where necessary.
- **Naming Conventions**: Use `snake_case` for variables and functions. Use `PascalCase` for modules.
- **Error Handling**: Use `pcall` for protected calls to handle errors gracefully.
- **Comments**: Use `--` for single-line comments and `--[[...]]` for multi-line comments.
- **Leader Key**: The leader key is set to `,` in `vimopts.lua`.

## Additional Notes

- Ensure `lazy.nvim` is cloned and set up as per `init.lua`.
- Treesitter is configured for multiple languages including Go, Rust, Lua, Python, Zig, SQL, and Markdown.
- The color scheme is set to `gruvbox`.
