return {
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            local set_keymap_n = function(lhs, rhs)
                vim.api.nvim_set_keymap("n", lhs, rhs, {})
            end
            set_keymap_n("j", "gj")
            set_keymap_n("k", "gk")
            set_keymap_n("$", "g$")
            set_keymap_n("0", "g0")

            local let = vim.g
            let.vimtex_compiler_latexmk = {
                aux_dir = "build",
                out_dir = "build",
            }

            let.tex_flavor = "latex"
            let.vimtex_view_method = "zathura"
            let.vimtex_quickfix_mode = 0
            let.tex_conceal = "abdmg"
            let.tex_fold_enabled = 1

            local set = vim.opt
            set.conceallevel = 1
            set.wrap = true
            set.linebreak = true
        end,
    },
}
