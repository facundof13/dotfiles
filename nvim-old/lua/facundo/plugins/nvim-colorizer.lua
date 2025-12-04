local setup, colorizer = pcall(require, "nvim-colorizer")
if not setup then
  return
end

colorizer.setup()
