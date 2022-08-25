local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local attach = require('plugins.lsp')

local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }, _config or {})
end

-- Иницализация gopls LSP для Go
-- https://github.com/golang/tools/tree/master/gopls
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-install
lspconfig.gopls.setup(config({
  on_attach = require('plugins.lsp'),
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'go.mod' },
  root_dir = util.root_pattern('go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  }
}))

-- clangd
lspconfig.clangd.setup{}
