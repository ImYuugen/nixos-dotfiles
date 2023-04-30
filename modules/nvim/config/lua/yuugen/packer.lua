local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'rose-pine/neovim',
        config = function() vim.cmd('colorscheme rose-pine') end
    }

    use {
        'folke/trouble.nvim',
        config = function()
            require('trouble').setup{
                icons = false
            }
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = { -- Not actually required but it's nicer like that
            { 'nvim-treesitter/playground' },
            { 'nvim-treesitter/nvim-treesitter-context' },
        },
    }

    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',branch = 'v1.x',
	    requires = {
		    -- LSP Support
		    {'neovim/nvim-lspconfig'},
		    {'williamboman/mason.nvim'},
		    {'williamboman/mason-lspconfig.nvim'},

		    -- Autocompletion
		    {'hrsh7th/nvim-cmp'},
		    {'hrsh7th/cmp-buffer'},
		    {'hrsh7th/cmp-path'},
		    {'hrsh7th/cmp-nvim-lsp'},
		    {'hrsh7th/cmp-nvim-lua'},
		    {'saadparwaiz1/cmp_luasnip'},

		    -- Snippets
		    {'rafamadriz/friendly-snippets'},
        }
    }

    use 'folke/zen-mode.nvim'
    use 'github/copilot.vim'
end)
