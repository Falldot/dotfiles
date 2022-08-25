local cmp = require('cmp')
local lspkind = require('lspkind')

local source_mapping = {
    buffer = '[Buffer]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    cmp_tabnine = '[TN]',
    path = '[Path]',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').expandable() then
                require('luasnip').expand()
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s", "c" }),
        ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { "i", "s", "c" }),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. ' ' .. menu
                end
            vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
    },
    sources = cmp.config.sources({
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

require('cmp_tabnine.config'):setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
})