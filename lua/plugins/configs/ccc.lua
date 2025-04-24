local ccc = require 'ccc'

return {
  alpha_show = 'hide',
  outputs = {
    ccc.output.hex,
    ccc.output.hex_short,
    ccc.output.css_rgb,
    ccc.output.css_rgba,
  },
  convert = {
    { ccc.picker.hex, ccc.output.css_rgb },
    { ccc.picker.css_rgb, ccc.output.hex },
  },
  recognize = { output = true },
}
