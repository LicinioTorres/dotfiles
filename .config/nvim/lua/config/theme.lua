local function set_midnight_bg()
  -- Enable true color support
  vim.opt.termguicolors = true

  -- Set the background for the main window (Normal) 
  -- and non-current windows (NormalNC)
  vim.api.nvim_set_hl(0, "Normal", { bg = "#070A11" , ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "#070A11" , ctermbg = "NONE" })
end

set_midnight_bg()

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme"}, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})


