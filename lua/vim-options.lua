-- General nvim options
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- To find debug log file, run :lua =require('vim.lsp.log').get_filename()
vim.lsp.set_log_level("debug")
