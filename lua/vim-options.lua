-- General nvim options
vim.g.mapleader = " "

vim.opt.nu = true             -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8 -- Show at least 8 lines and the end of file
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Do not back up files and add undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 1000

-- Disable mouse
-- vim.opt.mouse = ""

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.keymap.set("n", "<leader>cs", ":noh<CR>", { desc = "Clear search highlight" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "<leader>ct", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>R", "bufdo! e<CR>", { desc = "Reload all buffers (force)" })

-- Set up keybinds for terminal mode
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	-- Escape terminal mode
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- Move to window from terminal mode
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

	-- Window modifier from terminal mode
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Window keybinds
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-UP>", "<C-w>+", { desc = "Increase height of window" })
vim.keymap.set("n", "<C-DOWN>", "<C-w>-", { desc = "Decrease height of window" })
vim.keymap.set("n", "<C-LEFT>", "<C-w><", { desc = "Decrease width of window" })
vim.keymap.set("n", "<C-RIGHT>", "<C-w>>", { desc = "Increase width of window" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines down" })
-- Tips:
-- '*' highlights all occurences of a word under the cursor (and lets you search for it with /)
--
-- To find LSP debug log file, run :lua =require('vim.lsp.log').get_filename()
-- vim.lsp.set_log_level("debug")
