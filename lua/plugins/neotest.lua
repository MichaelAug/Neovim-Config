return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python"),
					require("neotest-rust"), -- Use cargo-nextest for this
				},
			})
			vim.keymap.set("n", "<leader>tr",function() neotest.run.run() end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tf",function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run current file" })
			vim.keymap.set("n", "<leader>td",function() neotest.run.run({strategy = "dap"}) end, { desc = "Debug nearest test" })
			vim.keymap.set("n", "<leader>ts",function() neotest.run.stop() end, { desc = "Stop nearest test" })
			vim.keymap.set("n", "<leader>ta",function() neotest.run.attach() end, { desc = "Attach to nearest test" })
		end,
	},
}
