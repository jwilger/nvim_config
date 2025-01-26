return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      elixir.setup({
        nextls = {
          enable = true,
          spitfire = false,
          init_options = {
            extensions = {
              credo = { enable = true },
            },
            experimental = {
              completions = {
                enable = true,
              },
            },
          },
        },
        elixirls = {
          enable = true,
          settings = {
            dialyzerEnabled = true,
            enableTestLenses = true,
          },
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
