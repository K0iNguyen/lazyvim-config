return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- LazyVim's editor.telescope extra builds this with a bare `make`, which resolves to
    -- MSYS2's make.exe. Neovim isn't started from an MSYS2 shell, so MSYSTEM is unset and
    -- the Makefile takes its "Windows but not msys2" branch, setting MKD to `cmd /C mkdir`.
    -- MSYS2's argument conversion then rewrites that `/C` into a Windows path, so cmd.exe
    -- sees no flag, opens an interactive prompt, and exits 0 at EOF -- build/ is never
    -- created and gcc dies with "cannot open output file build/libfzf.dll".
    -- MSYSTEM is only read inside the Makefile's Windows_NT branch, so this is a no-op
    -- elsewhere. nil leaves LazyVim's own build command (cmake) alone when make is absent.
    build = vim.fn.executable("make") == 1 and "make MSYSTEM=UCRT64" or nil,
  },
}
