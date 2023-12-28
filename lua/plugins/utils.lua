-- Small utility plugins
return {

  -- Auto tabstop and shiftwidth detect
  {'tpope/vim-sleuth'},

  -- Indent hints
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function ()
      require("ibl").setup({
        exclude = {
          filetypes = {
            'lspinfo',
            'packer',
            'checkhealth',
            'help',
            'man',
            'dashboard',
            ''
          }
        }
      })
    end
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- TODO: move out ui plugins to separate file
  -- Scrollbar
  {
    'petertriho/nvim-scrollbar',
    config = function ()
      require("scrollbar").setup({
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true, -- Requires gitsigns
          handle = true,
          search = true, -- Requires hlslens
        }
      })
    end
  },

  -- Search highlight
  {'kevinhwang91/nvim-hlslens'},

  -- Pretty diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Toggle Diagnostics window"})
      vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle workspace diagnostics"})
      vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "Toggle document diagnostics"})
      vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Toggle quickfix"})
      vim.keymap.set("n", "<leader>xL", function() require("trouble").toggle("loclist") end, { desc = "Toggle local list"})
      vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("lsp_references") end, { desc = "Toggle LSP references"})
    end
  },
}
