-- NOTE: These plugins don't work with NixOS so need to be disabled
-- all packages are installed through my NixOS config instead of mason
return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
}
