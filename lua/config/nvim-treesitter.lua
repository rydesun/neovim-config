local ts = require("nvim-treesitter.configs")

return ts.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gn",
            node_decremental = "gm",
            node_incremental = "gn",
            scope_incremental = "gc",
        }
    },
    move = {
        enable = true,
        set_jumps = true,
        goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer"
        },
        goto_next_start = {
            ["]]"] = "@class.outer",
            ["]m"] = "@function.outer"
        },
        goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer"
        },
        goto_previous_start = {
            ["[["] = "@class.outer",
            ["[m"] = "@function.outer"
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["if"] = "@function.inner",
                ac = "@class.outer",
                af = "@function.outer",
                ic = "@class.inner"
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>]p"] = "@parameter.inner"
            },
            swap_previous = {
                ["<leader>[p"] = "@parameter.inner"
            },
        }
    }
}
