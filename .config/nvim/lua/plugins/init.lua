local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup{
	function(use)
		use 'wbthomason/packer.nvim'

		-- Lua async lib
		-- https://github.com/nvim-lua/plenary.nvim
		use 'nvim-lua/plenary.nvim'

		-- Зависимости для движка автодополнения

		-- Плагин автодополнений
		-- https://github.com/hrsh7th/nvim-cmp
		use {
			'hrsh7th/nvim-cmp',
			config = function()
				require('plugins.cmp')
			end
		}
		-- https://github.com/hrsh7th/cmp-nvim-lsp
		use 'hrsh7th/cmp-nvim-lsp'
		-- https://github.com/hrsh7th/cmp-buffer
		use 'hrsh7th/cmp-buffer'
		-- https://github.com/hrsh7th/cmp-path
		use 'hrsh7th/cmp-path'
		use 'hrsh7th/cmp-cmdline'
		use 'hrsh7th/cmp-nvim-lua'
		-- https://github.com/saadparwaiz1/cmp_luasnip
		use 'saadparwaiz1/cmp_luasnip'

		-- Quickstart configs for Nvim LSP
		-- https://github.com/neovim/nvim-lspconfig
		use {
			"williamboman/nvim-lsp-installer",
			'neovim/nvim-lspconfig',
			config = function()
				require('plugins.lspconfig')
			end
		}

		-- Конфигурятор подсветки синтаксиса
		-- https://github.com/nvim-treesitter/nvim-treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function()
				-- так подгружается конфигурация конкретного плагина
				-- ~/.config/nvim/lua/plugins/treesitter.lua
				require('plugins.treesitter')
			end
		}

		-- Иконки
		-- https://github.com/kyazdani42/nvim-web-devicons
		use {
			'kyazdani42/nvim-web-devicons',
			config = function()
				require('nvim-web-devicons').setup({ default = true; })
			end
		}

		-- Удобное меню для обозрения проблем LSP
		use {
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup {}
			end,
		}

		-- ИИ автодополнения
		-- https://github.com/tzachar/cmp-tabnine
		use {
			'tzachar/cmp-tabnine',
			run='./install.sh'
		}

		use('onsails/lspkind-nvim')

		-- Навигация по файлам
		-- https://github.com/nvim-telescope/telescope.nvim
		use {
			'nvim-telescope/telescope.nvim',
			config = function()
				require('plugins.telescope')
			end
		}

		-- Движок сниппетов
		-- https://github.com/L3MON4D3/LuaSnip
		use {
			'L3MON4D3/LuaSnip',
			after = 'friendly-snippets',
			config = function()
				require('luasnip/loaders/from_vscode').load({
					paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' }
				})
			end
		}

		-- Набор готовых сниппетов для всех языков
		-- https://github.com/rafamadriz/friendly-snippets
		use 'rafamadriz/friendly-snippets'

		-- git ui
		-- https://github.com/TimUntersberger/neogit
		use {
			'TimUntersberger/neogit',
			config = function()
				require('neogit').setup()
			end
		}

		-- Стутус бар
		-- https://github.com/nvim-lualine/lualine.nvim
		use {
			'nvim-lualine/lualine.nvim',
			config = function()
				require('plugins.lualine')
			end
		}

		-- nnn
		-- https://github.com/luukvbaal/nnn.nvim
		-- use {
		-- 	"luukvbaal/nnn.nvim",
		-- 	config = function()
		-- 		require("nnn").setup()
		-- 	end
		-- }

		-- Коментирование кода
		-- https://github.com/numToStr/Comment.nvim
		use {
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup()
			end
		}

		use {
			'norcalli/nvim-colorizer.lua',
			config = function()
				require('plugins.nvim-colorizer')
			end
		}

		use {
			'kyazdani42/nvim-tree.lua',
			config = function()
				require('plugins.nvim-tree')
			end
		}

		-- Автоматические закрывающиеся скобки
		-- https://github.com/windwp/nvim-autopairs
		-- use {
		-- 	'windwp/nvim-autopairs',
		-- 	config = function()
		-- 		require("nvim-autopairs").setup()
		-- 	end
		-- }

		--------------------------------------
		-- Golang
		--------------------------------------

		-- Go LSP
		use {
			'olexsmir/gopher.nvim',
			config = function()
				require('plugins.gopher')
			end
		}

		local ok, error = pcall(require, 'plugins.lspconfig')
		if not ok then
			vim.notify('Error. Can\'t load LSP settings: ' .. error)
		end

		if packer_bootstrap then
			require('packer').sync()
		end
	end,

	log = { level = 'info' },
	config = {
		display = {
			prompt_border = 'single',
		},
		profile = {
			enable = true,
			threshold = 0,
		},
	},
}