-- Language server plugins
return {
  ---- NOTE: Uncomment this to use mason (in non-NixOS)
  -- LSP manager
  --{
  --  "williamboman/mason.nvim",
  --  config = function()
  --    require("mason").setup()
  --  end
  --},
  ---- Language server and nvim LSP functionality bridge
  --{
  --  "williamboman/mason-lspconfig.nvim",
  --  config = function()
  --    require("mason-lspconfig").setup({
  --      --ensure_installed = { "lua_ls", "rust" }
  --    })
  --  end
  --},

  -- nvim LSP functionality
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')

      -- NOTE: Initialise each LSP you want to use here
      -- In NixOS these LSPs need to be installed in home manager because NixOS cannot run dynamically linked executables (https://nix.dev/guides/faq#how-to-run-non-nix-executables)
      -- In normal linux distros LSPs can be installed using mason 
      lspconfig.lua_ls.setup({})
      lspconfig.rust_analyzer.setup({})

      -- LSP actions (WIP)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
