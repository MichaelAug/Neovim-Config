return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"alfaix/neotest-gtest"
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python"),
					require("neotest-rust"),
					require("neotest-gtest").setup({})
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
