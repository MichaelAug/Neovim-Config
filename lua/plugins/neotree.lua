-- File browser
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        window = {
          mappings = {
            ["<F5>"] = "refresh",
            ["l"] = "open",
            ["L"] = "focus_preview",
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>f", ":Neotree filesystem toggle reveal left<CR>", { desc = "File Explorer" })
  end,
}
