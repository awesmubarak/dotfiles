return {
  "wfxr/minimap.vim",
  build = "cargo install --locked code-minimap",
  cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  -- lazy = true,
  init = function()
    vim.g.minimap_width = 10
    vim.g.minimap_auto_start = 0
    vim.g.minimap_auto_start_win_enter = 0
    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
  end,
  config = function()
    -- Toggle minimap
    vim.api.nvim_set_keymap("n", "<leader>cM", ":MinimapToggle<CR>", { noremap = true, silent = true })
  end,
}
