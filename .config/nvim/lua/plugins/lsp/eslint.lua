local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {'*.js', '*.ts', '*.vue'},
	group = augroup,
	command = "EslintFixAll",
	desc = "Fix linter errors on save"
})

return {
    codeAction = {
        disableRuleComment = {
            enable = true,
            location = "separateLine"
        },
        showDocumentation = {
            enable = true
        }
    },
    codeActionOnSave = {
        enable = true,
        mode = "all"
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "yarn",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
        mode = "location"
    }
}