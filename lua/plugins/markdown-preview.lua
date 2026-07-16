-- markdown-preview.nvim (from the LazyVim lang.markdown extra): make the preview
-- reachable from another machine on the LAN -- e.g. a Windows 11 laptop editing
-- this Mac over SSH. The Mermaid diagrams in FILE-GRAPH.md render here via
-- mermaid.js.
--
-- markdown-preview still tries to open a browser on THIS Mac as usual (default
-- behavior kept). mkdp_echo_preview_url also prints the URL, so from the laptop
-- you can open http://<mac-lan-ip>:8888 in your Windows browser.
return {
  "iamcco/markdown-preview.nvim",
  init = function()
    vim.g.mkdp_open_to_the_world = 1 -- bind 0.0.0.0 so other LAN hosts can reach it
    vim.g.mkdp_port = "8888" -- fixed port (forward or hit directly over the LAN)
    vim.g.mkdp_echo_preview_url = 1 -- print the URL to open on another machine
  end,
}
