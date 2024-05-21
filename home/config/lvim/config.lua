-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "kanagawa-wave" -- Dark -> Light: dragon -> wave -> lotus
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "catppuccin-mocha"
-- lvim.builtin.lualine.options.theme = "catppuccin"
vim.opt.colorcolumn = "80,100"

lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- LSP Settings
require("lang.formatters")
require("lang.linters")
require("lang.installed")
vim.diagnostic.config({ virtual_text = false })

-- Additional Plugins
lvim.plugins = {
	-- Color Schemes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					notify = true,
					ts_rainbow = true,
					noice = true,
					neotest = true,
					mason = true,
					hop = true,
					neotree = true,
					which_key = true,
					window_picker = true,
					sandwich = true,
					navic = {
						enabled = true,
					},
					illuminate = {
						enabled = true,
					},
				},
			})
		end,
	},
	{ "savq/melange-nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{
		"rmehri01/onenord.nvim",
		config = function()
			require("onenord").setup({
				borders = false,
				styles = {
					comments = "italic",
				},
			})
		end,
	},
	{ "luisiacc/gruvbox-baby" },
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = true,
			})
		end,
	},
	--- Others... organize and figure out how to modularize plugin lists.
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},
	"ChristianChiarulli/swenv.nvim",
	"stevearc/dressing.nvim",
	"mfussenegger/nvim-dap-python",
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	"nvim-neotest/neotest-python",
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "f", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "F", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		config = function()
			vim.g.rnvimr_draw_border = 1
			vim.g.rnvimr_pick_enable = 1
			vim.g.rnvimr_bw_enable = 1
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "hiphish/rainbow-delimiters.nvim" },
	{
		"folke/lsp-colors.nvim",
		event = "BufRead",
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = 85, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{ "tpope/vim-repeat" },
	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})
		end,
	},
	{ "lambdalisue/suda.vim" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{ "machakann/vim-sandwich" },
	{
		"rasulomaroff/reactive.nvim",
		-- config = function()
		-- 	require("reactive").setup({
		-- 		load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
		-- 	})
		-- end,
	},
	{
		"zbirenbaum/copilot-cmp",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			-- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
			require("copilot").setup()
			-- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
			require("copilot_cmp").setup()
		end,
	},
}

-- Beginning to modularize this enormous config
require("neovide")
require("autocmd")
require("keymaps.lvim")
require("keymaps.windowpicker")
require("keymaps.rust")
require("lang.python")
require("lang.rust")
require("themes.kanagawa")
