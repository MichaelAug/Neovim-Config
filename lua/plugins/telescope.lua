-- Fuzzy finder
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
					},
				},
			})

			local builtin = require("telescope.builtin")
			local utils = require("telescope.utils")
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep files in current dir" })

			-- Git
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits (telescope)" })
			vim.keymap.set("n", "<leader>gS", builtin.git_status, { desc = "Git status (telescope)" })

			-- Search
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Files" })
			vim.keymap.set("n", "<leader>sF", function()
				builtin.find_files({ cwd = utils.buffer_dir() })
			end, { desc = "Files in current buffer directory" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffers (sorted last used)" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Commands" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", '<leader>s"', builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Marks" })
			vim.keymap.set("n", "<leader>sv", builtin.vim_options, { desc = "Vim options" })
			vim.keymap.set("n", "<leader>sR", builtin.resume, { desc = "Resume previous picker" })
		end,
	},

	-- Menu dialog UI extension
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},

	-- Use telescope for LSP UI
	{
		"Slotos/telescope-lsp-handlers.nvim",
		config = function()
			require("telescope-lsp-handlers").setup()
		end,
	},
}
