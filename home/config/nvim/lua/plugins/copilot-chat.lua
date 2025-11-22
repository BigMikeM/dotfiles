-- CopilotChat.nvim - Official GitHub Copilot Chat for Neovim
-- Repository: https://github.com/CopilotC-Nvim/CopilotChat.nvim

---@type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      debug = false, -- Enable debugging
      -- See defaults: https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua
      model = "gpt-4", -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      show_help = true, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
      mappings = {
        -- Use tab for completion
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        -- Close the chat
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        -- Accept the diff
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = "gmy",
        },
        -- Show the diff
        show_diff = {
          normal = "gmd",
        },
        -- Show the prompt
        show_system_prompt = {
          normal = "gmp",
        },
        -- Show the user selection
        show_user_selection = {
          normal = "gms",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      chat.setup(opts)

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      -- Restore CopilotChat from history
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then vim.bo.filetype = "markdown" end
        end,
      })
    end,
    keys = {
      -- ====================================================================
      -- AI/Copilot Chat Group (<Leader>a)
      -- ====================================================================

      -- Help & Prompts
      {
        "<Leader>ah",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "Help actions",
      },
      {
        "<Leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt actions",
      },
      {
        "<Leader>ap",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "Prompt actions (visual)",
      },

      -- Chat Operations
      {
        "<Leader>ac",
        "<cmd>CopilotChatToggle<cr>",
        desc = "Toggle chat",
      },
      {
        "<Leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick chat",
      },
      {
        "<Leader>ai",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Ask input",
      },
      {
        "<Leader>al",
        "<cmd>CopilotChatReset<cr>",
        desc = "Clear chat history",
      },

      -- Code Analysis (<Leader>ax prefix for code actions)
      {
        "<Leader>axe",
        "<cmd>CopilotChatExplain<cr>",
        desc = "Explain code",
      },
      {
        "<Leader>axt",
        "<cmd>CopilotChatTests<cr>",
        desc = "Generate tests",
      },
      {
        "<Leader>axr",
        "<cmd>CopilotChatReview<cr>",
        desc = "Review code",
      },
      {
        "<Leader>axR",
        "<cmd>CopilotChatRefactor<cr>",
        desc = "Refactor code",
      },
      {
        "<Leader>axn",
        "<cmd>CopilotChatBetterNamings<cr>",
        desc = "Better naming",
      },
      {
        "<Leader>axf",
        "<cmd>CopilotChatFixDiagnostic<cr>",
        desc = "Fix diagnostic",
      },
      {
        "<Leader>axd",
        "<cmd>CopilotChatDebugInfo<cr>",
        desc = "Debug info",
      },

      -- Visual Mode
      {
        "<Leader>av",
        ":CopilotChatVisual<cr>",
        mode = "x",
        desc = "Chat with selection",
      },
      {
        "<Leader>ai",
        ":CopilotChatInline<cr>",
        mode = "x",
        desc = "Inline chat",
      },

      -- Git Integration (<Leader>ag prefix)
      {
        "<Leader>agm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Commit message (all)",
      },
      {
        "<Leader>ags",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "Commit message (staged)",
      },
    },
  },
}
