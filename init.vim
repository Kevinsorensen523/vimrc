" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Enable file type detection and plugin functionality
filetype plugin indent on

" Set the clipboard to use the system clipboard
set clipboard=unnamedplus

" Enable mouse support
set mouse=a

" Disable netrw at the very start of your init.vim
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Optionally enable 24-bit color
set termguicolors

" Initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'ojroques/vim-oscyank'
" Theme plugin
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim'

Plug 'christoomey/vim-tmux-navigator'

" Status line plugin
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons

" Telescope plugin
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-lua/plenary.nvim'

" CoC plugin for LSP and autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NvimTree plugin
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons

" Autopairs plugin for automatic closing of brackets and quotes
Plug 'windwp/nvim-autopairs'

" Treesitter and autotag plugin for automatic closing of HTML tags
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'

call plug#end()

" Set colorscheme
autocmd VimEnter * colorscheme tokyonight-storm

" Lualine settings
lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" Telescope settings
lua << EOF
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'|', '|', '|', '|', '|', '|', '|', '|'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

" NvimTree settings
lua << EOF
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  end,
})
EOF

" Keybinding to toggle NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>

" CoC settings
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use `K` to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <C-c> "+y
vnoremap <C-c> "+y
nnoremap <C-x> "+x
vnoremap <C-x> "+x
nnoremap <C-v> "+gP
vnoremap <C-v> "+gP

noremap <S-Up> <Up>v
noremap <S-Down> <Down>v
noremap <S-Left> <Left>v
noremap <S-Right> <Right>v

nnoremap <C-a> ggVG
" Prettier format on save
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.json,*.md CocCommand prettier.formatFile

" Autopairs settings
lua << EOF
require('nvim-autopairs').setup{}
EOF

" Treesitter and autotag settings
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"bash", "c", "cpp", "javascript", "json", "lua", "python", "typescript", "html", "css"}, -- List the languages you want
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  autotag = {
    enable = true,
  }
}
EOF


