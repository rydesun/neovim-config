local wilder = require('wilder')

wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            -- 用vim比python的匹配更准
            language = 'vim',
            -- 任意位置开始匹配
            fuzzy = 2,
        })
    )
})

wilder.set_option('renderer', wilder.wildmenu_renderer(
    wilder.wildmenu_lightline_theme({
        highlighter = wilder.basic_highlighter(),
        separator = ' · ',
    })
))
