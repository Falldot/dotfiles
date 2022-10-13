vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#232315 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#231A23 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guibg=#231A23 gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}