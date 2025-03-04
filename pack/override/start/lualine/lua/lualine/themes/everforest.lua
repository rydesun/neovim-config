local configuration = vim.fn['everforest#get_configuration']()
local palette = vim.fn['everforest#get_palette'](
  configuration.background, configuration.colors_override
)

if configuration.transparent_background == 2 then
  palette.bg1 = palette.none
end

return {
  normal = {
    a = { bg = palette.statusline2[1], fg = palette.bg0[1] },
    b = { bg = palette.bg3[1], fg = palette.grey2[1] },
    c = { bg = palette.bg1[1], fg = palette.grey1[1] }
  },
}
