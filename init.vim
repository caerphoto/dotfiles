syntax on
syntax enable
syntax sync minlines=50
syntax sync maxlines=100
scriptencoding utf-8
filetype on
filetype indent on
filetype plugin on

" Remove existing autocommands, in case this file is sourced more than once.
:autocmd!

autocmd BufNewFile,BufRead *.mako setlocal syntax=mako
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown linebreak textwidth=80 colorcolumn=80 numberwidth=5
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.html.hbs set filetype=html
autocmd BufNewFile,BufRead *.hbs.html set filetype=html
autocmd BufNewFile,BufRead *.pug set filetype=jade
autocmd BufNewFile,BufRead *.pp setlocal ft=puppet synmaxcol=500
autocmd BufNewFile,BufRead .PHSEARCH_SETTINGS set filetype=yaml
autocmd BufNewFile,BufRead *phgroup.com*.conf,generic.conf,httpd.conf,server.conf set filetype=apache
autocmd FileType apache syntax on
autocmd FileType gitcommit setlocal colorcolumn=51
autocmd FileType text|markdown setlocal fo+=al " 'a' is automatic paragraph formatting
autocmd FileType html setlocal colorcolumn=0 textwidth=0 shiftwidth=2 tabstop=2 softtabstop=2 " Allow HTML lines to be much longer than other code.
autocmd FileType sh setlocal textwidth=0
autocmd BufRead * match ExtraWhitespace /\s\+$/  
autocmd BufRead * highlight ExtraWhitespace ctermbg=white guifg=#FF0000
autocmd BufWritePre *.js lua vim.lsp.buf.format()

" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

set nocompatible
set backup
if has('win32') || has('win16')
    let g:backupdir=expand(stdpath('config') . '\backup')
else
    let g:backupdir=expand(stdpath('config') . '/backup')
endif
if !isdirectory(g:backupdir)
   call mkdir(g:backupdir, "p")
endif
let &backupdir=g:backupdir

set updatetime=2000 " milliseconds to wait before writing backup file
set hidden " Allow editing of different files without saving current buffer first.
" set runtimepath^=~/.vim,~/.vim/after
" set packpath^=~/.vim
" set backupdir=~/.vim/backup
" set directory=~/.vim/tmp
set path+=** " Allow recursive searching in current directory
set mouse=a

set relativenumber
set number
set cursorline
set listchars=trail:•,tab:┅┅⟩,nbsp:░,space:·
set showmatch
set showmode
set fillchars=vert:▍,fold:\ ,foldopen:▼,foldsep:\ ,foldclose:▶
set laststatus=2 " 2 means always
set statusline=%#TabLineSel#[%02n]%0*\ %{expand('%:.')}\ %([%3*%m%*%r%h]%)%=%4l,%c\ ·\ %3P\ of\ %L
set diffopt=vertical
set signcolumn=no

set foldlevel=99
set foldnestmax=4
set foldcolumn=1
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

set textwidth=100
set colorcolumn=100
set synmaxcol=200
set breakindent

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set autoindent
set backspace=indent,eol,start
set diffopt=filler,context:6

set formatoptions=tcrqnljv1 " see fo-table help for details

set lazyredraw " Don't update screen while executing macros.
set visualbell
set scrolloff=4
set list
set wildmode=longest,list " Show all matches when using tab completion of filenames
set completeopt=menu,longest,preview " More sensible completion options.
set noea " keep existing window sizes when splitting or closing a window

set gdefault " Automatically assume the :s /g flag (replace every match on a ling).
set ignorecase
set smartcase
set hlsearch
set incsearch

" \ is a bit awkward to reach on ISO keyboard layout
let mapleader = ","

nnoremap <silent> <D-f> :NvimTreeToggle<CR>
nnoremap <silent> <C-t> :NvimTreeToggle<CR>

" Bubble single lines
nnoremap <D-k> ddkP
nnoremap <D-j> ddp

" Bubble paragraph
nnoremap <D-K> dap{{p
nnoremap <D-J> dap}p

nmap <D-[> :bp<CR>
nmap <D-]> :bn<CR>
noremap <tab> %
nnoremap <leader>l gqq
nnoremap <leader>p gqap
nnoremap <F5> :set list!<cr>
inoremap <F5> <C-o>:set list!<cr>
nnoremap <silent> <leader>h :nohl<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-F> :set foldmethod=expr<cr>

" Expand %% into the current file's path.
cnoremap %% <C-R>=expand('%:.:h').'/'<cr>

inoremap kj <esc>
inoremap <C-l> <Del>

vnoremap <silent> K :m'>-2<CR>gv=gv
vnoremap <silent> J :m'>+1<CR>gv=gv

if exists("g:neovide") || exists("g:goneovim") || exists("g:fvim_loaded")
    " Make stuff feel more macOS-native
    let g:neovide_input_use_logo = v:true
    nnoremap <silent> <D-v> "+p
    inoremap <silent> <D-v> <Esc>"+pa
    vnoremap <silent> <D-c> "+y
    set guifont=Iosevka\ Nerd\ Font:h13

    let g:neovide_cursor_vfx_mode = ""
    let g:neovide_cursor_animation_length = 0
    let g:neovide_refresh_rate_idle = 5
    let g:neovide_floating_z_height = 2
    let g:neovide_floating_shadows = v:false
    cd ~
endif

if has('gui_running') || exists("g:neovide") || exists("g:goneovim")
    " set background=light
    set background=dark
else
    set background=dark
endif

" set guioptions+=er


let g:go_bin_path = '~/Applications/homebrew/opt/go/bin'
let g:matchparen_insert_timeout=5
let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"

" ------------- Plugins ------------------

call plug#begin()
" Essential things
Plug 'nvim-lua/plenary.nvim' " misc handy Lua functions
Plug 'williamboman/mason.nvim' " for easy language server installs
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " better syntax parsing/highlighting
Plug 'neovim/nvim-lspconfig' " sensible default configs for LSP
Plug 'L3MON4D3/LuaSnip'       " ?
Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'       " buffer source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " file/buffer picker
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Useful features
Plug 'tpope/vim-commentary', { 'branch': 'master' } " commenting plugin
Plug 'tpope/vim-sleuth', { 'branch': 'master' }     " set shiftwidth etc automatically from buffer content
Plug 'windwp/nvim-autopairs'                        " auto-pair (), {} etc
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'linrongbin16/lsp-progress.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context' " show current module/class/function at the top
Plug 'kevinhwang91/promise-async' " dependency for nvim-ufo
Plug 'kevinhwang91/nvim-ufo' " better folding
Plug 'j-hui/fidget.nvim' " LSP progress popup
Plug 'folke/flash.nvim' " quick navigation within buffers

Plug 'rodjek/vim-puppet/' " Puppet syntax highlighting

Plug 'natecraddock/workspaces.nvim'
Plug 'natecraddock/sessions.nvim'

" Visual things
Plug 'nvim-tree/nvim-web-devicons'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' " lines pointing at LSP stuff

" GoNeovim has these built in but the plugin versions are better/more customisable
"Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }  " scrollbar
Plug 'lukas-reineke/indent-blankline.nvim' " indent guides

" Colour scheme
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
call plug#end()

" Tab line customisation, from:
" https://stackoverflow.com/questions/7238113/customising-the-colours-of-vims-tab-bar

" The MyTabLabel() function is called for each tab page to get its label:
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let lbl = bufname(buflist[winnr - 1])
  return fnamemodify(lbl, ":t")
endfunction

" This function sets the whole tab line
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    let wc = tabpagewinnr(i+1, "$")
    if wc == 1
        let wct = ''
    else
        if i + 1 == tabpagenr()
            let wct = '%#TabLineSelWC# / ' . wc . '%#TabLineSel#'
        else
            let wct =    '%#TabLineWC# / ' . wc . '%#TabLine#'
        end
    endif

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')}' . wct . ' '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999X[X]'
  endif

  return s
endfunction

set tabline=%!MyTabLine()


lua << EOL

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("mason").setup()

require'nvim-treesitter.configs'.setup {
    -- ensure_installed = { "javascript", "rust", "ruby", "go", "markdown", "html" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"apache", "xml", "tmux"},
    },
}

-- Global LSP floating border override
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(client, bufnr)
    print("LSP attached")
    -- LSP-specific mappings. They're in this function so they only apply for LSP-enabled buffers
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<space>r',  vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K',         vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga',        vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gd',        vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi',        vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'g[',        vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'g]',        vim.diagnostic.goto_next, bufopts)
end
vim.o.mousemoveevent = true

local caps = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local standard_servers = { 'rust_analyzer', 'gopls', 'solargraph', 'pylsp', 'vtsls' }
local custom_settings = {
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                completion = {
                    callable = { snippets = "add_parentheses" },
                },
                checkOnSave = { command = "clippy" },
            },
        },

    }
}

for _, lsp in ipairs(standard_servers) do
    lspconfig[lsp].setup { capabilities = caps, on_attach = on_attach, settings = custom_settings[lsp] }
end


-- require'treesitter-context'.setup({
--    max_lines = 2,
-- })

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
}

require("sessions").setup({
    events = { "WinEnter" },
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})
require("workspaces").setup({
    hooks = {
        open_pre = {
            "SessionsStop",
            "silent %bdelete!",
        },
        open = function()
            require("sessions").load(nil, { silent = true })
        end,
    }
})

require("fidget").setup({
    notification = {
        window = {
            winblend = 20,
            border = 'rounded',
        }
    }
})

local flash = require("flash")
vim.keymap.set('n', 'S', function() flash.jump() end, { silent = true })
vim.keymap.set('n', 'H', function() flash.treesitter() end, { silent = true })

local telescope = require('telescope')
local tsc_actions = require('telescope.actions')
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = tsc_actions.close
            }
        },
        disable_devicons = true,
    },
    pickers = {
        buffers = {
            only_cwd = true,
        }
    }
}
telescope.load_extension('fzf')
local tsc_builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>f', tsc_builtin.find_files, {})
vim.keymap.set('n', '<space>b', tsc_builtin.buffers, {})
vim.keymap.set('n', '<space>g', tsc_builtin.live_grep, {})
vim.keymap.set('n', '<space>d', tsc_builtin.diagnostics, {})
vim.keymap.set('n', '<space>w', '<Cmd>Telescope workspaces<CR>', {silent=true})
vim.keymap.set("n", "<space>t", ":Telescope file_browser<CR>")

telescope.load_extension('ui-select')
telescope.load_extension('workspaces')
telescope.load_extension "file_browser"

local nap = require("nvim-autopairs")
local remap = vim.api.nvim_set_keymap
nap.setup {
    check_ts = true,
    map_bs = false,
    map_cr = false,
}
_G.MUtils= {}
MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return nap.esc('<c-y>')
    else
      return nap.esc('<c-e>') .. nap.autopairs_cr()
    end
  else
    return nap.autopairs_cr()
  end
end

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return nap.esc('<c-e>') .. nap.autopairs_bs()
  else
    return nap.autopairs_bs()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })


local vlines = require("lsp_lines")
vlines.setup()
vim.diagnostic.config({ virtual_text = false, virtual_lines = { highlight_whole_line = false } })
vim.keymap.set(
    "",
    "<Leader>v",
    vlines.toggle,
    { desc = "Toggle lsp_lines" }
)

local whitespace = {}
if vim.opt.background._value == "light" then
    local ibl_highlights = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowGreen",
        "RainbowCyan",
        "RainbowBlue",
        "RainbowViolet",
    }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed",    { bg = "#faeded" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { bg = "#fafaed" })
        vim.api.nvim_set_hl(0, "RainbowGreen",  { bg = "#eefaed" })
        vim.api.nvim_set_hl(0, "RainbowCyan",   { bg = "#edf7fa" })
        vim.api.nvim_set_hl(0, "RainbowBlue",   { bg = "#f2edfa" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { bg = "#faedf5" })
    end)
    whitespace = { highlight = ibl_highlights }
end
require("ibl").setup {
    scope = { enabled = false },
    indent = { highlight = "FoldColumn", char = "▏" },
    whitespace = whitespace,
}

require("nvim-tree").setup({
    view = { float = {
        enable = true,
        open_win_config = {
            relative = "editor",
            width = 80,
            height = 70,
            row = 2,
            col = 5,
            border = "rounded",
        },
    }},
})

require('rose-pine').setup({
    dark_variant = "moon",
    styles = {
        italic = false,
        bold = true,
        transparency = false,
    },
    highlight_groups = {
        DiffAdd =             { bg = "#114422" },
        DiffDelete =          { bg = "#551111",   fg = "#880000" },
        DiffText =            { fg = "#88ffaa" },
        StatusLine =          { bg = "foam",      fg = "base" },
        StatusLineNC =        { bg = "pine",      fg = "base" },
        FoldColumn =          {                   fg = "highlight_high" },
        IndentBlanklineChar = {                   fg = "highlight_high" },
        FloatBorder =         {                   fg = "text" },
        TelescopeBorder =     {                   fg = "text" },
        VertSplit =           {                   fg = "muted" },
        TabLineFill =         { bg = "base" },
        TabLine =             { bg = "muted",     fg = "base" },
        TabLineWC =           { bg = "muted",     fg = "highlight_high" },
        TabLineSel =          { bg = "text",      fg = "base" },
        TabLineSelWC =        { bg = "text",      fg = "pine" },

    },
})

vim.cmd("colorscheme rose-pine")

EOL

hi StatusLine   blend=0
hi StatusLineNC blend=0
hi DiagnosticVirtualTextInfo  blend=0
hi DiagnosticVirtualTextHint  blend=0
hi DiagnosticVirtualTextWarn  blend=0
hi DiagnosticVirtualTextError blend=0
hi DiagnosticVirtualTextHint  blend=0

" GoNeovim's undercurls cover the text a bit too much; underline is cleaner
if exists("g:goneovim")
    hi DiagnosticUnderlineError gui=underline
    hi DiagnosticUnderlineWarn gui=underline
    hi DiagnosticUnderlineInfo gui=underline
    hi DiagnosticUnderlineHint gui=underline
endif
