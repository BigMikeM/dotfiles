-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        zsh = "sh",
        sh = "sh",
      },
      filename = {
        [".zshrc"] = "sh",
        [".zshenv"] = "sh",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- ====================================================================
        -- Navigation
        -- ====================================================================
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- ====================================================================
        -- Which-Key Group Names
        -- ====================================================================
        ["<Leader>a"] = { desc = "󰚩 AI/Copilot" },
        ["<Leader>ag"] = { desc = " Git" },
        ["<Leader>ax"] = { desc = "󰘦 Code Actions" },
        ["<Leader>b"] = { desc = "󰓩 Buffers" },
        ["<Leader>c"] = { desc = " LSP/Code" },
        ["<Leader>d"] = { desc = " Debugger" },
        ["<Leader>f"] = { desc = "󰈞 Find" },
        ["<Leader>g"] = { desc = "󰊢 Git" },
        ["<Leader>l"] = { desc = " LSP" },
        ["<Leader>p"] = { desc = "󰏖 Packages" },
        ["<Leader>s"] = { desc = "󰆍 Search/Session" },
        ["<Leader>t"] = { desc = " Terminal" },
        ["<Leader>u"] = { desc = "󰔡 UI/UX" },
        ["<Leader>x"] = { desc = "󱖫 Diagnostics/Trouble" },

        -- ====================================================================
        -- Buffer Management
        -- ====================================================================
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick buffer to close",
        },
        ["<Leader>bD"] = {
          function()
            require("astrocore.buffer").close(0, true)
          end,
          desc = "Force close buffer",
        },

        -- ====================================================================
        -- Quick Actions
        -- ====================================================================
        ["<Leader>w"] = { "<cmd>w<cr>", desc = "Save" },
        ["<Leader>W"] = { "<cmd>wall<cr>", desc = "Save all" },
        ["<Leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" },
        ["<Leader>Q"] = { "<cmd>confirm qall<cr>", desc = "Quit all" },
        ["<Leader>n"] = { "<cmd>enew<cr>", desc = "New file" },

        -- ====================================================================
        -- Disable unwanted defaults (prevent conflicts)
        -- ====================================================================
        -- Disable if these conflict with your workflow
      },

      -- ====================================================================
      -- Terminal Mode Mappings
      -- ====================================================================
      t = {
        ["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
        ["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Navigate left" },
        ["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Navigate down" },
        ["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Navigate up" },
        ["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Navigate right" },
      },

      -- ====================================================================
      -- Visual Mode Mappings
      -- ====================================================================
      v = {
        ["<"] = { "<gv", desc = "Indent left and reselect" },
        [">"] = { ">gv", desc = "Indent right and reselect" },
      },

      -- ====================================================================
      -- Insert Mode Mappings
      -- ====================================================================
      i = {
        ["jk"] = { "<Esc>", desc = "Exit insert mode" },
        ["kj"] = { "<Esc>", desc = "Exit insert mode" },
      },
    },
  },
}
