-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- ============================================================================
-- VSCode Neovim Integration
-- ============================================================================
if vim.g.vscode then
  -- VSCode extension detected
  -- Disable heavy plugins that VSCode handles better
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- Use VSCode's clipboard
  vim.opt.clipboard = "unnamedplus"

  -- Simpler settings for VSCode
  vim.opt.timeoutlen = 300
  vim.opt.ttimeoutlen = 10

  -- VSCode-specific keybindings
  local vscode = require("vscode-neovim")

  -- File operations
  vim.keymap.set("n", "<Leader>w", function() vscode.action("workbench.action.files.save") end, { desc = "Save file" })
  vim.keymap.set("n", "<Leader>q", function() vscode.action("workbench.action.closeActiveEditor") end, { desc = "Close editor" })
  vim.keymap.set("n", "<Leader>Q", function() vscode.action("workbench.action.closeAllEditors") end, { desc = "Close all editors" })

  -- File explorer
  vim.keymap.set("n", "<Leader>e", function() vscode.action("workbench.view.explorer") end, { desc = "Explorer" })
  vim.keymap.set("n", "<Leader>o", function() vscode.action("workbench.action.quickOpen") end, { desc = "Quick open" })

  -- Search
  vim.keymap.set("n", "<Leader>ff", function() vscode.action("workbench.action.quickOpen") end, { desc = "Find files" })
  vim.keymap.set("n", "<Leader>fw", function() vscode.action("workbench.action.findInFiles") end, { desc = "Find word" })
  vim.keymap.set("n", "<Leader>fs", function() vscode.action("workbench.action.gotoSymbol") end, { desc = "Find symbols" })

  -- Git
  vim.keymap.set("n", "<Leader>gg", function() vscode.action("workbench.view.scm") end, { desc = "Git" })
  vim.keymap.set("n", "<Leader>gc", function() vscode.action("git.commit") end, { desc = "Git commit" })
  vim.keymap.set("n", "<Leader>gp", function() vscode.action("git.push") end, { desc = "Git push" })
  vim.keymap.set("n", "<Leader>gl", function() vscode.action("git.pull") end, { desc = "Git pull" })

  -- LSP
  vim.keymap.set("n", "gd", function() vscode.action("editor.action.revealDefinition") end, { desc = "Go to definition" })
  vim.keymap.set("n", "gD", function() vscode.action("editor.action.revealDeclaration") end, { desc = "Go to declaration" })
  vim.keymap.set("n", "gr", function() vscode.action("editor.action.goToReferences") end, { desc = "Go to references" })
  vim.keymap.set("n", "gi", function() vscode.action("editor.action.goToImplementation") end, { desc = "Go to implementation" })
  vim.keymap.set("n", "gy", function() vscode.action("editor.action.goToTypeDefinition") end, { desc = "Go to type definition" })
  vim.keymap.set("n", "K", function() vscode.action("editor.action.showHover") end, { desc = "Hover" })
  vim.keymap.set("n", "<Leader>ca", function() vscode.action("editor.action.quickFix") end, { desc = "Code action" })
  vim.keymap.set("n", "<Leader>cr", function() vscode.action("editor.action.rename") end, { desc = "Rename" })
  vim.keymap.set("n", "<Leader>cf", function() vscode.action("editor.action.formatDocument") end, { desc = "Format" })

  -- Diagnostics
  vim.keymap.set("n", "[d", function() vscode.action("editor.action.marker.prev") end, { desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", function() vscode.action("editor.action.marker.next") end, { desc = "Next diagnostic" })
  vim.keymap.set("n", "<Leader>xl", function() vscode.action("workbench.actions.view.problems") end, { desc = "Diagnostics list" })

  -- Comments (if not using VSCode's default)
  vim.keymap.set("n", "gcc", function() vscode.action("editor.action.commentLine") end, { desc = "Comment line" })
  vim.keymap.set("x", "gc", function() vscode.action("editor.action.commentLine") end, { desc = "Comment selection" })

  -- Folding
  vim.keymap.set("n", "za", function() vscode.action("editor.toggleFold") end, { desc = "Toggle fold" })
  vim.keymap.set("n", "zR", function() vscode.action("editor.unfoldAll") end, { desc = "Unfold all" })
  vim.keymap.set("n", "zM", function() vscode.action("editor.foldAll") end, { desc = "Fold all" })

  -- Terminal
  vim.keymap.set("n", "<Leader>tt", function() vscode.action("workbench.action.terminal.toggleTerminal") end, { desc = "Toggle terminal" })
  vim.keymap.set("n", "<Leader>tn", function() vscode.action("workbench.action.terminal.new") end, { desc = "New terminal" })

  -- Splits
  vim.keymap.set("n", "<Leader>sv", function() vscode.action("workbench.action.splitEditorRight") end, { desc = "Split vertical" })
  vim.keymap.set("n", "<Leader>sh", function() vscode.action("workbench.action.splitEditorDown") end, { desc = "Split horizontal" })

  -- Focus navigation between VSCode editor groups
  vim.keymap.set("n", "<C-h>", function() vscode.action("workbench.action.focusLeftGroup") end, { desc = "Focus left" })
  vim.keymap.set("n", "<C-j>", function() vscode.action("workbench.action.focusBelowGroup") end, { desc = "Focus down" })
  vim.keymap.set("n", "<C-k>", function() vscode.action("workbench.action.focusAboveGroup") end, { desc = "Focus up" })
  vim.keymap.set("n", "<C-l>", function() vscode.action("workbench.action.focusRightGroup") end, { desc = "Focus right" })

  -- Buffer/tab navigation
  vim.keymap.set("n", "]b", function() vscode.action("workbench.action.nextEditor") end, { desc = "Next editor" })
  vim.keymap.set("n", "[b", function() vscode.action("workbench.action.previousEditor") end, { desc = "Previous editor" })
  vim.keymap.set("n", "<Leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end, { desc = "Close editor" })

else
  -- Standard Neovim/Neovide configuration
  -- Set up custom filetypes
  -- vim.filetype.add {
  --   extension = {
  --     zsh = "sh",
  --     sh = "sh",
  --   },
  --   filename = {
  --     [".zshrc"] = "sh",
  --     [".zshenv"] = "sh",
  --   },
  -- }
end
