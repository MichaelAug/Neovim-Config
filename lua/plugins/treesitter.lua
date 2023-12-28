-- Syntax tree parser (syntax highlighting)
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "c", "cpp", "c_sharp", "lua", "python", "rust", "nix", "bash", "vim", "vimdoc", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "json", "markdown", "markdown_inline" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

-- Useful keybinds:
-- '=' on selection -> indents code
