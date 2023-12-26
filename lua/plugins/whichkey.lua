return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function ()
    -- Define group names
    require("which-key").register({
      ["<leader>"] = {
        f = { name = "File" },
        l = { name = "LSP" },
        s = { name = "Search" },
        c = { name = "Clear" },
      }
    })

  end
}
