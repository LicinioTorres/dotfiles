vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "text", "typst", "tex" },
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})
