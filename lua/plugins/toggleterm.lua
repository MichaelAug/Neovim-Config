return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {},
		config = function()
			require("toggleterm").setup({
				size =20,
				vim.keymap.set("n", "<C-x>", ":ToggleTerm<CR>", { desc = "Toggle terminal" }),
				vim.keymap.set("t", "<C-x>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle terminal (in terminal mode)" }),
			})
		end,
	},
}

