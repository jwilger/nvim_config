return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.extra"
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        -- mini.ai provides default mappings for a, i, an, in, al, il.
        -- Here we add extra custom textobjects.
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(),
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
        },
      }
    end,
    config = function(_, opts)
      local ai = require("mini.ai")
      ai.setup(opts)

      -- Using which-key.add() with the new spec format:
      local function add_mini_ai_mappings()
        local ok, wk = pcall(require, "which-key")
        if not ok then
          vim.defer_fn(add_mini_ai_mappings, 100)
          return
        end

        wk.add({
          {
            mode = { "o", "x" },
            { "U", desc = "usage (no dot): for function calls without a dot" },
            { "a", desc = "around textobject" },
            { "al", desc = "around last textobject" },
            { "an", desc = "around next textobject" },
            { "c", desc = "class: for classes" },
            { "d", desc = "digits: for numbers" },
            { "e", desc = "word (case-sensitive): for words with mixed case" },
            { "f", desc = "function: for functions" },
            { "i", desc = "inside textobject" },
            { "il", desc = "inside last textobject" },
            { "in", desc = "inside next textobject" },
            { "o", desc = "block: for blocks, conditionals, loops" },
            { "t", desc = "tags: for HTML/XML tags" },
            { "u", desc = "usage: for function calls" },
          },
        })
      end

      add_mini_ai_mappings()
    end,
  },
}
