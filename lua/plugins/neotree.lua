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
    vim.keymap.set('n', '<leader>fe', function()
      local p = vim.fn.expand "%:p"
      if vim.fn.filereadable(p) == 1 then
        vim.cmd(
          "Neotree action=focus source=filesystem position=left reveal_file=" .. p
        )
      end
    end, { desc = 'File Explorer' })
  end
}
