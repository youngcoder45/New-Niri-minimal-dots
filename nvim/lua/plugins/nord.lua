if true then
  return {}
end

return {
  "shaunsingh/nord.nvim",
  config = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    require("nord").set()
  end,
}
