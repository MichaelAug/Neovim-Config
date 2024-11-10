-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.title = true

-- Set these when using Neovide
if vim.g.neovide then
  vim.o.guifont = "Source Code Pro:h11"
end
