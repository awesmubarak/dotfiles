-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- UFO folding
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })
map("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Open folds except kinds" })
map("n", "zm", function()
  require("ufo").closeFoldsWith()
end, { desc = "Close folds with" })

-- Change Mason keymap
map("n", "<leader>cM", "<cmd>Mason<cr>", { desc = "Mason" })

-- Remove the default Mason keymap
vim.keymap.del("n", "<leader>cm")

-- Minimap toggle
map("n", "<leader>cm", ":MinimapToggle<CR>", { desc = "Toggle Minimap" })
