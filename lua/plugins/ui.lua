return {
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup({})
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup({
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true, -- Requires gitsigns
          handle = true,
          search = true, -- Requires hlslens
        },
      })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  -- Pins buffers to windows in toggleterm, neo-tree, vim-fugitive etc. windows
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = function()
      require("toggleterm").setup({
        size = 20,
        vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle terminal" }),
        vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle terminal (in terminal mode)" }),
      })
    end,
  },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = false,
      vim.keymap.set("n", "<leader>p", ":Precognition toggle<CR>", { desc = "Toggle Precognition" }),
    },
  },
}
