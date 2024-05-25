return {
	-- nvim LSP functionality
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({
					buffer = bufnr,
					preserve_mappings = false
				})
			end)

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- NOTE: Initialise each LSP you want to use here
			-- In NixOS these LSPs need to be installed in home manager because NixOS cannot run dynamically linked executables (https://nix.dev/guides/faq#how-to-run-non-nix-executables)
			-- In normal linux distros LSPs can be installed using mason
			-- Make sure to advertise cmp_nvim_lsp capabilities to language servers
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.nil_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.ruff_lsp.setup {
				init_options = {
					settings = {
						args = {},
					}
				}
			}
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					completion = {
						callSnippet = "Both",
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
				settings = {
					python = {
						analysis = {
							autoImportCompletion = true,
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "off", -- Try turning this on and cry at all the errors
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>L", "<cmd>:LspInfo<cr>", { desc = "Info" })
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- invoke formatters with vim.lsp.buf.format() (binding set for this in nvim-lspconfig)
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.nixfmt,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.black, -- Python formatter
					null_ls.builtins.formatting.clang_format,
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero").cmp_action()
			local cmp_format = require("lsp-zero").cmp_format({ details = true })

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				--- (Optional) Show source name in completion menu
				formatting = cmp_format,
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})
		end,
	},
	{ "L3MON4D3/LuaSnip" },
}
