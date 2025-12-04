local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

local mason_nvim_dap_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status then
  return
end

local dap_ui_status, dap_ui = pcall(require, "dapui")
if not dap_ui_status then
  return
end

mason.setup()
dap_ui.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "sumneko_lua",
    "angularls",
  }
})

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "styleua",
    "eslint_d",
  },
})

mason_nvim_dap.setup({
  automatic_installation = true,
  automatic_setup = true,
  ensure_installed = {
  "node2",
  "chrome"
  }
})

mason_nvim_dap.setup_handlers()

vim.fn.sign_define('DapBreakpoint', {
  text = '🟥',
  texthl = '',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define('DapStopped', {
  text = '🟢',
  texthl = '',
  linehl = '',
  numhl = '',
})

