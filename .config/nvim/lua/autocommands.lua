local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt
local opt_local = vim.opt_local

autocmd({'BufEnter'}, {
    pattern = '*',
    callback = function()
        opt.fo:remove('c')
        opt.fo:remove('r')
        opt.fo:remove('o')
    end
})

-- Удаление всех плавающих пробелов на запись
local TrimWhiteSpaceGrp = augroup('TrimWhiteSpaceGrp', {})
autocmd('BufWritePre', {
	group = TrimWhiteSpaceGrp,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

-- Подсветка скопированных строк
local YankHighlightGrp = augroup('YankHighlightGrp', {})
autocmd('TextYankPost', {
	group = YankHighlightGrp,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

--------------------------------------
-- Golang
--------------------------------------

local timeout_ms = 1000

-- Форматирование Go файлов на запись
autocmd({'BufWritePre'}, {
    pattern = '*.go',
    callback = function()
        vim.lsp.buf.formatting_sync(nil, timeout_ms)
    end
})

-- Сортировка Go импортов на сохранение файла
autocmd({'BufWritePre'}, {
    pattern = '*.go',
    callback = function()
        local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
        params.context = { only = {'source.organizeImports'} }
        local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout_ms)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end,
})

autocmd({'FileType'}, {
    pattern = 'go',
    callback = function()
        opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
    end
})