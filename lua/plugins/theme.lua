-- Nvim Theme
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("rose-pine").setup({
      dim_inactive_windows = false,
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "#8ff7a9",
        git_change = "#30bdff",
        git_delete = "#e0303f",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        -- Alternatively, set all headings at once.
        -- headings = "subtle",
      },
    })

    vim.cmd.colorscheme("rose-pine-main")
  end,
}
