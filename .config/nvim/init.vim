" set leader to SPACE
let mapleader = " "
nnoremap <SPACE> <NOP>

" ### CURSOR & LINES ###
set cursorline
set cursorcolumn
set number
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
"  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
"augroup END
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent

" ### CLIPBOARD ###
set clipboard=unnamedplus

" paste/copy SECONDARY (Ctrl+c/Ctrl+v)
noremap y "+y
noremap p "+p
noremap Y "+Y
noremap P "+P

" prevent overriding clipboard on deletions
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
nnoremap s "_s
vnoremap x "_x
vnoremap d "_d
vnoremap D "_D
vnoremap c "_c
vnoremap s "_s
vnoremap p "+pgv"+y`>
vnoremap P "+Pgv"+y`>
xnoremap p "+pgv"+y`>
xnoremap P "+Pgv"+y`>

" traditional 'cut' with leader d
nnoremap <leader>D "+D
vnoremap <leader>d "+d
nnoremap <leader>d "+d


" insert mode mappings
" -- 'jk' for quitting insert mode
inoremap jk <ESC>
" -- 'kj' for quitting insert mode
" inoremap kj <ESC> " annoying
" -- 'jj' for quitting insert mode
inoremap jj <ESC>

" -- Move current line / block with Alt-j/k ala vscode.
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi


" normal mode mappings
" -- Move current line / block with Alt-j/k a la vscode.
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" visual mode mappings
" -- Better indenting
vnoremap < <gv
vnoremap > >gv

" visual block mappings
" -- Move selected line / block of text in visual mode
xnoremap J :move '>+1<CR>gv-gv
xnoremap K :move '<-2<CR>gv-gv
xnoremap <A-j> :m '>+1<CR>gv-gv
xnoremap <A-k> :m '<-2<CR>gv-gv

" switch tabs
nnoremap <silent>L :tabprevious<CR>
nnoremap <silent>H :tabnext<CR>

" split vertically
nnoremap <C-x> :vertical sb#<CR>

" Navigate windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" close tab
nnoremap <leader>q :q<CR>

" Remove highlight
nnoremap <leader>h :noh<CR>

" ### Whitepsace characters ###
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
nnoremap <leader>w :set list!<CR>


" ### PLUGINS ###
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'nvim-lua/plenary.nvim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'folke/which-key.nvim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-surround'
"Plug 'nvim-lua/popup.nvim'
"Plug 'sheerun/vim-polyglot'

" themes
Plug 'rakr/vim-one'

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
call plug#end()

" ### NERDTree config ###
nnoremap <leader>e :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ### which-key config ###
set timeoutlen=500

" ### Telescope ###
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ### colorschemes ###
set termguicolors
syntax on
colorscheme one
set background=dark

function ToggleBackgroundColor()
    let &background = &background == "dark" ? "light" : "dark"
endfunction
nnoremap <silent><leader>i :call ToggleBackgroundColor()<CR>

let g:airline_theme='one'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr=' '
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.colnr=':'


" ### LSP ###
set completeopt=menu,menuone,noselect

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-q> <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <C-q> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <silent> <C-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
" F14 is equal to SHIFT + F2
nnoremap <silent> <F14> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <F2> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <C-A-l> <cmd>lua vim.lsp.buf.formatting()<CR>

" ### Snippets ###
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

lua << EOF
  require("which-key").setup()
  require("nvim-lsp-installer").setup()
  require("telescope").setup()
  require("Comment").setup()

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['bashls'].setup { capabilities = capabilities }
  require('lspconfig')['tsserver'].setup { capabilities = capabilities }
  require('lspconfig')['pyright'].setup { capabilities = capabilities }
--  require('lspconfig')['pylsp'].setup { capabilities = capabilities }
  require('lspconfig')['yamlls'].setup { capabilities = capabilities }
  require('lspconfig')['vimls'].setup { capabilities = capabilities }
EOF

