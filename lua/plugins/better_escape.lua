return {
  "max397574/better-escape.nvim",
  opts = function(_, opts)
    opts = {
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
      },
    }
    return opts
  end,
}
