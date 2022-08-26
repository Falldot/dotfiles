local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify('Error. NvimTree is not installed')
    return
end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

nvim_tree.setup({
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = true,
    open_on_setup_file  = true,
    open_on_tab         = true,
    ignore_ft_on_setup  = {},
    hijack_cursor       = false,
    update_cwd          = false,
    diagnostics = {
        enable = false,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        }
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    view = {
        width = 30,
        height = 30,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        }
    }
})

local function vimclosenvimtree()
    vim.cmd("if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern  = '*',
    callback = vimclosenvimtree,
    desc     = 'Automatically close nvim-tree if it is last window',
    nested   = true
})