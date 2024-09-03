return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        if filetype == "python" then
          return { "treesitter", "indent" }
        end
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "Comment" })
        return newVirtText
      end,
    },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      require("ufo").setup(opts)

      -- Define the custom fold expression function globally
      _G.custom_fold_expr = function()
        local line = vim.fn.getline(vim.v.lnum)
        if line:match("^%s*'''") or line:match('^%s*"""') then
          if vim.fn.foldlevel(vim.v.lnum - 1) == 0 then
            return ">1"
          end
        elseif vim.fn.foldlevel(vim.v.lnum - 1) > 0 then
          if line:match("^%s*'''") or line:match('^%s*"""') then
            return "<1"
          end
        end
        return "="
      end

      -- Custom folding for Python
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.custom_fold_expr()"

          -- Set up a custom foldtext function
          vim.opt_local.foldtext = [[v:lua.require'ufo'.foldtext()]]

          -- Override UFO's fold text handler for Python files
          local ufo = require("ufo")
          ufo.setup({
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
              local firstLine = vim.fn.getline(lnum)
              if firstLine:match("^%s*'''") or firstLine:match('^%s*"""') then
                return { { "  Docstring: " .. (endLnum - lnum + 1) .. " lines", "Folded" } }
              end
              -- For non-docstring folds, use the default handler
              return ufo.defaultFoldVirtTextHandler(virtText, lnum, endLnum, width, truncate)
            end,
          })
        end,
      })
    end,
  },
}
