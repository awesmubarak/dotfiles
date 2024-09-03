-- Default neotree, changes the width and displays hidden files

return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    require("neo-tree").setup({
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    })
  end,
}
