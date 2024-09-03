return {
  "tomasky/bookmarks.nvim",
  config = function()
    require("bookmarks").setup({
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
      keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function(bufnr)
        local bm = require("bookmarks")
        local map = vim.keymap.set

        -- # TODO: move this to the keymaps folder, make it work with which key, add thing for telescoe
        vim.api.nvim_set_keymap(
          "n",
          "<leader>Bm",
          ":lua require('bm').bookmark_toggle()<CR>",
          { noremap = true, silent = true, desc = "Toggle bookmark" }
        )
        map("n", "<leader>Bm", bm.bookmark_toggle) -- this is bad, but actually works
        map("n", "<leader>Bi", bm.bookmark_ann) -- add or edit mark annotation at current line
        map("n", "<leader>Bc", bm.bookmark_clean) -- clean all marks in local buffer
        map("n", "<leader>Bn", bm.bookmark_next) -- jump to next mark in local buffer
        map("n", "<leader>Bp", bm.bookmark_prev) -- jump to previous mark in local buffer
        map("n", "<leader>Bl", bm.bookmark_list) -- show marked file list in quickfix window
        map("n", "<leader>Bx", bm.bookmark_clear_all) -- removes all bookmarks
      end,
    })

    require("telescope").load_extension("bookmarks")
  end,
}
