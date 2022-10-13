local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local installer = require('nvim-lsp-installer')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local attach = require('plugins.lsp')


installer.setup({})

local config = {
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "none",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "none",
})

local servers = installer.get_installed_servers()
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in pairs(servers) do
  local ok, settings = pcall(require, "plugins.lsp." .. server.name)
  if not ok then
    settings = {}
  end

  lspconfig[server.name].setup({
    on_attach = attach,
    capabilities = capabilities,
    settings = settings,
  })
end