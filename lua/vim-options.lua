-- General nvim options
vim.g.mapleader = " "

vim.opt.nu = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8  -- Show at least 8 lines and the end of file
vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>cs', ':noh<CR>', { desc = 'Clear search highlight'})
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard'})
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = 'Yank line to system clipboard'})

-- To find LSP debug log file, run :lua =require('vim.lsp.log').get_filename()
-- vim.lsp.set_log_level("debug")
