-- General nvim options
vim.g.mapleader = " "

vim.opt.nu = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8  -- Show at least 8 lines and the end of file

vim.keymap.set('n', '<leader>cs', ':noh<CR>', {}) -- Clear search highlight

-- To find LSP debug log file, run :lua =require('vim.lsp.log').get_filename()
-- vim.lsp.set_log_level("debug")
