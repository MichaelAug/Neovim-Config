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
				map("n", "<leader>gD", gs.toggle_deleted, { desc = "toggle git show deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
			end,
		},
	},

	-- Git diff view
	-- NOTE: diffview shortcuts will only be active in diffview.
	-- If there are conflicting shortcuts, diffview shortcuts will be used when executed quickly (before which-key menu is shown)
	-- TIP: use <leader>b to hide file menu and go to right window
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
						winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
					},
					merge_tool = {
						-- Config for conflicted files in diff views during a merge or rebase.
						layout = "diff3_mixed",
						disable_diagnostics = false,
						winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
					},
				},
			})
			vim.keymap.set("n", "<leader>gd", function()
				if next(require("diffview.lib").views) == nil then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewClose")
				end
			end, { desc = "Diff view toggle" })
			vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Diff view file history (git log)" })
			vim.keymap.set("n", "<leader>gR", ":DiffviewRefresh<CR>", { desc = "Diff view refresh" })
		end,
	},

	{ "tpope/vim-fugitive" },
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function ()
			vim.keymap.set("n", "<C-g>", ":LazyGit<CR>", { desc = "Open LazyGit" })
		end
	},
	{
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup()

			vim.keymap.set("n", "<leader>gb", ":BlameToggle window<CR>", { desc = "Toggle blame window" })
		end
	}

}
