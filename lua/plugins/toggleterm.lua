return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {},
		config = function()
			require("toggleterm").setup({
				size =20,
				vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" }),
			})
		end,
	},
}
