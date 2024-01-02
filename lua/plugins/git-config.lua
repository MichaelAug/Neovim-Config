return {
	-- Git signs and hunk actions
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to next hunk" })

				map({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to previous hunk" })

				-- Actions
				-- visual mode
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })

				map("n", "<leader>gr", gs.reset_buffer, { desc = "git Reset buffer" })
				map("n", "<leader>gs", gs.stage_buffer, { desc = "git Stage buffer" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = false })
				end, { desc = "git blame line" })
				map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "git diff against last commit" })
				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
			end,
		},
	},

	-- Git diff view
	-- NOTE: diffview shortcuts will only be active in diffview.
	-- If there are conflicting shortcuts, diffview shortcuts will be used when executed quickly (before which-key menu is shown)
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				vim.keymap.set("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Diff view" }),
			})
		end,
	},

	-- Git interface
	-- NOTE: this will generate warning:
	-- - WARNING Configured `hg_cmd` is not executable: 'hg'
	-- hg is Mercurial which is not used
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({})
		end,
	},

	{'tpope/vim-fugitive'}
}
