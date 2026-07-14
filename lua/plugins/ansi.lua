return {
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      local baleia = require("baleia").setup({})

      -- Command to colorize current buffer on demand
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      -- Auto-colorize .log and .ansi files when opened
      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        pattern = { "*.log", "*.ansi" },
        callback = function()
          baleia.once(vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },
}
