return {
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
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
            set.conceallevel = 2
        end,
    },
}
