-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "kanagawa-wave" -- Dark -> Light: dragon -> wave -> lotus
vim.opt.guifont = "MonoLisa Nerd Font:h12"
vim.opt.colorcolumn = "80,100"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>rn"] = ":IncRename "
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
}
-- generic LSP settings

lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"yaml",
	"vim",
	"sql",
}
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "shellharden",
		filetypes = { "shell", "bash", "zsh", "sh" },
	},
	{ command = "markdownlint" },
	{ command = "stylua" },
	{ command = "black" },
})

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.lua" }

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "shellcheck",
		filetypes = { "shell", "bash", "zsh", "sh" },
	},
	{ command = "pyright", filetypes = { "python" } },
})

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"rust",
	"vim",
	"javascript",
	"json",
	"toml",
	"yaml",
	"lua",
}

-- Additional Plugins
lvim.plugins = {
	"simrat39/rust-tools.nvim",
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
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	"ChristianChiarulli/swenv.nvim",
	"stevearc/dressing.nvim",
	"mfussenegger/nvim-dap-python",
	"nvim-neotest/neotest",
	"nvim-neotest/neotest-python",
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{ "tpope/vim-surround" },
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
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
	{ "p00f/nvim-ts-rainbow" },
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
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
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
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						enabled = false,
					},
				},
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "1.*",
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
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{ "lambdalisue/suda.vim" },
}

-- An awesome method to jump to windows
local picker = require("window-picker")

vim.keymap.set("n", ",w", function()
	local picked_window_id = picker.pick_window({
		include_current_win = true,
	}) or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Swap two windows using the awesome window picker
local function swap_windows()
	local window = picker.pick_window({
		include_current_win = false,
	})
	local target_buffer = vim.fn.winbufnr(window)
	-- Set the target window to contain current buffer
	vim.api.nvim_win_set_buf(window, 0)
	-- Set current window to contain target buffer
	vim.api.nvim_win_set_buf(0, target_buffer)
end

vim.keymap.set("n", ",W", swap_windows, { desc = "Swap windows" })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.json", "*.jsonc", "*.md" },
	command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})

-- Beginning to modularize this enormous config
require("lang.python")
require("lang.rust")
require("theme.kanagawa")
