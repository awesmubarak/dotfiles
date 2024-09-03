return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Disable virtual text
        virtual_text = false,
        -- Show signs in the sign column
        signs = true,
        -- Update diagnostics in insert mode
        update_in_insert = false,
        -- Use a floating window for diagnostics
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        -- Add other language servers you need
      },
    },
  },
}
