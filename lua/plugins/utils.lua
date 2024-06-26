-- Small utility plugins
return {
	-- Auto tabstop and shiftwidth detect
	{ "tpope/vim-sleuth" },

	-- https://github.com/folke/which-key.nvim/issues/218
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				---Line-comment toggle keymap
				line = "gcc",
				---Block-comment toggle keymap
				block = "gbc",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = "gc",
				---Block-comment keymap
				block = "gbc",
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = "gcO",
				---Add comment on the line below
				below = "gco",
				---Add comment at the end of line
				eol = "gcA",
			},
		},
	},

	-- Pretty diagnostics list
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end, { desc = "Toggle Diagnostics window" })
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end, { desc = "Toggle workspace diagnostics" })
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end, { desc = "Toggle document diagnostics" })
			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").toggle("quickfix")
			end, { desc = "Toggle quickfix" })
			vim.keymap.set("n", "<leader>xL", function()
				require("trouble").toggle("loclist")
			end, { desc = "Toggle local list" })
			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").toggle("lsp_references")
			end, { desc = "Toggle LSP references" })
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				-- options used when flash is activated through
				-- a regular search with `/` or `?`
				search = {
					-- when `true`, flash will be activated during regular search by default.
					-- You can always toggle when searching with `require("flash").toggle()`
					enabled = false,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},

	-- Finds and lists all of the TODO, HACK, BUG, etc comment
	-- in your project and loads them into a browsable list.
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
		-- stylua: ignore
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
		},
	},
}
