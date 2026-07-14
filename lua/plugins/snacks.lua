return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            config = function(opts)
              -- keep all the default explorer behavior
              opts = require("snacks.picker.source.explorer").setup(opts)

              local Tree = require("snacks.explorer.tree")
              local EActions = require("snacks.explorer.actions")
              local PActions = require("snacks.picker.actions")

              -- open files without leaving the explorer
              opts.actions.confirm = function(picker, item, action)
                if not item then
                  return
                elseif picker.input.filter.meta.searching then
                  return EActions.update(picker, { target = item.file })
                elseif item.dir then
                  Tree:toggle(item.file)
                  return EActions.update(picker, { refresh = true })
                end

                -- file: run jump() "inside" the main window, then snap focus back
                vim.api.nvim_win_call(picker.main, function()
                  local old = picker.opts.jump.close
                  picker.opts.jump.close = false
                  PActions.jump(picker, item, action)
                  picker.opts.jump.close = old
                end)

                vim.schedule(function()
                  if not picker.closed then
                    picker.list.win:focus()
                  end
                end)
              end

              return opts
            end,
          },
        },
      },
    },
  },
}
