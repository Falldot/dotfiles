local map = vim.api.nvim_set_keymap
local opt = {noremap = true}

function ns(key, command)
    map('', key, command, opt)
end

function nm(key, command)
	map('n', key, command, opt)
end

function im(key, command)
	map('i', key, command, opt)
end

function vm(key, command)
	map('v', key, command, opt)
end

function tm(key, command)
	map('t', key, command, opt)
end

-- copy
ns('<C-c>', '"+y')
-- paste
ns('<C-v>', '"+p')
-- cut
ns('<C-x>', '"+d')
-- paste in insert mode
ns('<C-v>', '<Esc>"+pa')

vm('<', '<gv')
vm('>', '>gv')

-- Telescope
nm('gd', '<cmd>Telescope lsp_definitions<CR>')      -- Объявления в LSP
nm('<leader>o', '<cmd>Telescope oldfiles<CR>')      -- Просмотр недавних файлов
nm('<leader>p', '<cmd>Telescope git_files<CR>')     -- Поиск файлов
nm('<leader>b', '<cmd>Telescope git_branches<CR>')  -- Ветки в Git
nm('<leader>f', '<cmd>Telescope live_grep<CR>')     -- Поиск строки
nm('<leader>q', '<cmd>Telescope buffers<CR>')       -- Буфферы

-- Nvim-tree
nm('<leader>t', '<cmd>NvimTreeToggle<CR>')

-- Tabs
nm('<Tab>', '>>_')
nm('<S-Tab>', '<<_')
vm('<Tab>', '>>_')
vm('<S-Tab>', '<<_')
ns('<Tab>', '\t')
ns('<S-Tab>', '\b')

-- opening terminal with shortcut
ns('<Leader><CR>', '<Cmd>silent !$TERM &<CR>')

-- jumping back and forth
ns('<C-K>', '<C-O>')

ns('<C-L>', '<C-I>')

-- comments
vm('<C-/>', 'gcc')
im('<C-/>', 'gcc')
