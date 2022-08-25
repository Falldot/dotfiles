local color_gamma = require("colorscheme.utils").color_gamma
local gamma = require("colorscheme.config").gamma

local colors = {
    black = "#06080A",
    bg0 = "#121212", -- Background
    bg1 = "#181818", -- Select row
    bg4 = "#545454", -- Comments

    yellow = "#FFCB6B", -- Class, Struct, Namespaces, Custom types
    green = "#C3E88D", -- Stings, Symbols
    violet = "#C792EA", -- Types, Keywords
    blue = "#82AAFF", -- Function
    anakiwa = "#89DDFF", -- Macros, Prepocession
    red = "#f07178", -- Parameters
    white = "#ffffff", -- Other
    fg = "#ffffff",

    bg2 = "#212234",
    bg3 = "#353945",
    bg5 = "#282c34",
    bg_red = "#FE6D85",
    bg_green = "#98C379",
    bg_blue = "#9FBBF3",
    diff_red = "#773440",
    diff_green = "#587738",
    diff_blue = "#354A77",
    diff_add = "#1E2326",
    diff_change = "#262b3d",
    diff_delete = "#281B27",
    orange = "#F6955B",
    cyan = "#38A89D",
    purple = "#A485DD",
    grey = "#4A5057",
    none = "NONE",
}

local function gamma_correction(colors)
    local colors_corrected = {}
    for k, v in pairs(colors) do
        colors_corrected[k] = color_gamma(v, gamma)
    end
    return colors_corrected
end

return gamma_correction(colors)