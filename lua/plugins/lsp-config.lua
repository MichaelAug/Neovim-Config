-- Language server plugins
return {
  -- Read about LSP setup here: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/you-might-not-need-lsp-zero.md
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        -- Load snippets from vscode
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
        mapping = cmp.mapping.preset.insert({
          -- Enter key confirms completion item
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Ctrl + space triggers completion menu
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      })
    end,
  },
  -- nvim LSP functionality
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- NOTE: Initialise each LSP you want to use here
      -- In NixOS these LSPs need to be installed in home manager because NixOS cannot run dynamically linked executables (https://nix.dev/guides/faq#how-to-run-non-nix-executables)
      -- In normal linux distros LSPs can be installed using mason
      lspconfig.lua_ls.setup({})
      lspconfig.rust_analyzer.setup({})

      -- Map this key always
      vim.keymap.set("n", "<leader>lI", "<cmd>:LspInfo<cr>", { desc = "Info" })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          -- Function to set LSP keybinds under <leader>l
          local function set_lsp_keymap(suffix, command, desc)
            local full_key = "<leader>l" .. suffix
            vim.keymap.set("n", full_key, command, {
              desc = desc,
              buffer = event.buf,
            })
          end

          -- Map these keys on LSP attach only
          set_lsp_keymap("k", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
          set_lsp_keymap("d", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
          set_lsp_keymap("D", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
          set_lsp_keymap("i", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")

          set_lsp_keymap("o", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to Type definition")
          set_lsp_keymap("r", "<cmd>lua vim.lsp.buf.references()<cr>", "References")
          set_lsp_keymap("s", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help")
          set_lsp_keymap("R", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
          set_lsp_keymap("f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format")
          set_lsp_keymap("a", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")

          set_lsp_keymap("l", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open float diagnostics")
          set_lsp_keymap("p", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic")
          set_lsp_keymap("n", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")
        end,
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local code_actions = null_ls.builtins.code_actions
      -- local completion = null_ls.builtins.completion

      null_ls.setup({
        sources = {

          -- invoke formatters with vim.lsp.buf.format() (binding set for this in nvim-lspconfig)
          formatting.stylua,

          -- TODO: finish nix and python setup
          code_actions.statix,
          --code_actions.gitsigns

          --completion.luasnip
        },
      })
    end,
  },
}
