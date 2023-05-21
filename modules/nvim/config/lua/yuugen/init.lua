require('yuugen.map')
require('yuugen.set')
require('yuugen.packer')

local augroup = vim.api.nvim_create_augroup
local YuugenGroup = augroup('Yuugen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require('plenary.reload').reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = YuugenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Load lazy plugins
require('mason').setup()

-- Catpuccin Config
require('catppuccin').setup({
    flavour = 'mocha',
    background = {
        light = 'latte',
        dark = 'mocha',
    },
    integrations = {
        mason = true,
        native_lsp = true,
        treesitter = true,
        cmp = true,
    },
})
