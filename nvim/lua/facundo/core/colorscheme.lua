local status, _ = pcall(vim.cmd, "colorscheme moonlight")
if not status then
  print("Colorscheme not found")
  return
end

