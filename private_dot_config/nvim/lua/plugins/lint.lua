-- Disable line too long markdown lint

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint" },
    }

    -- Configure markdownlint to use your config file
    lint.linters.markdownlint.args = {
      "--config",
      vim.fn.expand("~/.markdownlint.json"),
    }

    -- Create commands for linting
    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, {})

    -- Set up autocommands for automatic linting
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
