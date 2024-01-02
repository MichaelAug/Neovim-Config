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
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
        -- TAB to autocomplete or cycle through options
        -- SHIFT-TAB to cycle in reverse
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<s-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      local lspconfig = require("lspconfig")

      require('mason').setup()
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = { "pyright", "lua_ls" }
      }

      -- NOTE: Initialise each LSP you want to use here
      -- In NixOS these LSPs need to be installed in home manager because NixOS cannot run dynamically linked executables (https://nix.dev/guides/faq#how-to-run-non-nix-executables)
      -- In normal linux distros LSPs can be installed using mason
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup ({})

      -- Map this key always
      vim.keymap.set("n", "<leader>lI", "<cmd>:LspInfo<cr>", { desc = "Info" })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          -- Function to set LSP keybinds under <leader>l
          local function set_lsp_keymap(keybind, command, desc)
            vim.keymap.set("n", keybind, command, {
              desc = desc,
              buffer = event.buf,
            })
          end

          -- Map these keys on LSP attach only
          set_lsp_keymap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
          set_lsp_keymap("<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
          set_lsp_keymap("<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
          set_lsp_keymap("<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")

          set_lsp_keymap("<leader>lo", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to Type definition")
          set_lsp_keymap("<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", "References")
          set_lsp_keymap("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help")
          set_lsp_keymap("<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
          set_lsp_keymap("<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format")
          set_lsp_keymap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")

          set_lsp_keymap("<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open float diagnostics")
          set_lsp_keymap("<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic")
          set_lsp_keymap("<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")
        end,
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting

      null_ls.setup({
        sources = {
          -- invoke formatters with vim.lsp.buf.format() (binding set for this in nvim-lspconfig)
          formatting.stylua,
        },
      })
    end,
  },
}
