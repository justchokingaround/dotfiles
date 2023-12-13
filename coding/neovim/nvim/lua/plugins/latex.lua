return {
    {
        'lervag/vimtex',
        lazy = false, -- otherwise reverse search does not work
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'

            vim.g.vimtex_imaps_leader = ';'
            vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover

            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_quickfix_method = vim.fn.executable('pplatex') == 1 and 'pplatex' or 'latexlog'
            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_matchparen_enabled = 0

            vim.g.vimtex_syntax_conceal_disable = 1 -- disable conceal completely
            -- vim.api.nvim_create_autocmd({ 'FileType' }, {
            --     group = vim.api.nvim_create_augroup('lazyvim_vimtex_conceal', { clear = true }),
            --     pattern = { 'bib', 'tex' },
            --     callback = function()
            --         vim.opt_local.conceallevel = 2
            --     end,
            -- })

            vim.g.vimtex_toc_config = {
                layer_status = { ['content'] = 1, ['label'] = 0, ['todo'] = 1, ['include'] = 0 },
                show_help = 0,
                todo_sorted = 0,
            }

            vim.g.vimtex_quickfix_ignore_filters = { [[but the package provides `simpler-wick']] }
        end,
    },

    -- Add BibTeX/LaTeX to treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'bibtex', 'latex' })
            end
            if type(opts.highlight.disable) == 'table' then
                vim.list_extend(opts.highlight.disable, { 'latex' })
            else
                opts.highlight.disable = { 'latex' }
            end
        end,
    },

    -- Correctly setup lspconfig for LaTeX 🚀
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                texlab = {
                    keys = {
                        { 'gK', '<plug>(vimtex-doc-package)', desc = 'Vimtex Docs', silent = true },
                    },
                    settings = {
                        texlab = {
                            forwardSearch = {
                                -- https://github.com/latex-lsp/texlab/wiki/Previewing
                                executable = 'zathura',
                                args = { '--synctex-forward', '%l:1:%f', '%p' },
                            },
                        },
                    },
                },
            },
        },
    },
}
