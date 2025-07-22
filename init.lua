-- THANKS TEEJ!!!!
-- Netrw stuff
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.foldmethod = "indent"
vim.cmd('set textwidth=120')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 7

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- CHRISTIAN'S BINDS 
-- `<leader>t` for terminal
vim.keymap.set('n', '<leader>t', '<Cmd>split | terminal<CR>A', {desc = 'open terminal in split' })
-- `<C-[h/j/k/l]> for switching between splits
vim.api.nvim_set_keymap('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
-- emacs-style `C-c C-c` to run a python file
vim.keymap.set('n', '<C-c><C-c>', function()
    vim.cmd('w')
    local the_command = string.format("split | term bash -c 'python3 %s; echo; echo \"[ ENTER to close ]\"; read'", vim.fn.expand("%:p"))
    vim.cmd(the_command)
end, {desc = 'run script' })

vim.keymap.set('n', '<leader>,', '<Cmd>b#<CR>', {desc = 'goto most recent buffer' })
vim.keymap.set('n', '<leader>e', '<C-w>s<C-w>J<Cmd>e .<CR>', {desc = 'open netrw in new split below current' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
      local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
    {'shatur/neovim-ayu'},
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'goolord/alpha-nvim',
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            local alpha = require 'alpha'
            local startify = require'alpha.themes.startify'
            startify.section.header.val = {
            [[⠄⠄⣴⣶⣤⡤⠦⣤⣀⣤⠆⠄⠄⠄⠄⠄⣈⣭⣭⣿⣶⣿⣦⣼⣆⠄⠄⠄⠄⠄⠄⠄⠄]],
            [[⠄⠄⠄⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦⠄⠄⠄⠄⠄⠄]],
            [[⠄⠄⠄⠄⠄⠈⠄⠄⠄⠈⢿⣿⣟⠦⠄⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄⠄⠄⠄⠄]],
            [[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⢧⠄⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄⠄⠄⠄     .:: .::====  .::====  .::    .::= === .::  === .:: .::======= ]],
            [[⠄⠄⢀⠄⠄⠄⠄⠄⠄⢠⣿⣿⣿⠈⠄⠄⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀⠄⠄     ::: :::  === :::  === :::    :::===== :::  === ::: ::: === ===]],
            [[⠄⠄⢠⣧⣶⣥⡤⢄⠄⣸⣿⣿⠘⠄⠄⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄⠄     ===  =======  ======= ===    ======== ===  === === === === ===]],
            [[⠄⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠄⠄⠄⢊⣿⣿⡏⠄⠄⢸⣿⣿⡇⠄⢀⣠⣄⣾⠄⠄⠄     ===      ===      === ===    === ====  ======  === ===     ===]],
            [[⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀⠄⢸⢿⣿⣿⣄⠄⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄⠄     ===  =====    =====   === == ===  ===    ==    === ===     ===]],
            [[⠙⠃⠄⠄⠄⣼⣿⡟⠌⠄⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠐⣿⣿⡇⠄⠛⠻⢷⣄]],
            [[⠄⠄⠄⠄⠄⢻⣿⣿⣄⠄⠄⠄⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟⠄⠫⢿⣿⡆⠄⠄⠄⠁                     Ricing Neovim is not a hobby.]],
            [[⠄⠄⠄⠄⠄⠄⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃⠄⠄⠄⠄]],
	 }
         startify.section.top_buttons.val = {
             startify.button( "c", "Config" , ":e ~/.config/nvim/init.lua<CR>"),
             startify.button( "~", "Home" , ":e ~/.<CR>"),
             startify.button( "p", "Python REPL" , ":term python3<CR>A"),
         }
         -- disable MRU
         startify.section.mru.val = { { type = "padding", val = 0 } }
         -- disable MRU cwd
         startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
         -- disable nvim_web_devicons
         startify.nvim_web_devicons.enabled = false
         startify.section.footer = {
             { type = "text", val = "footer" },
         }
         -- ignore filetypes in MRU

         startify.mru_opts.ignore = function(path, ext)
             return
                     (string.find(path, "COMMIT_EDITMSG"))
                 or  (vim.tbl_contains(default_mru_ignore, ext))
         end
         alpha.setup(startify.config)
    end },
})

require('ayu').setup({
    mirage = false,
    terminal = true,
    overrides = {},
})

vim.cmd('colorscheme ayu')
require('mason').setup()

local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
    settings = {
        python = {
            pythonPath = "/usr/bin/python3"
        }
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.handlers["textDocument/inlayHint"] = vim.lsp.with(
  vim.lsp.inlay_hint, {
    highlight = "Comment"
    -- options here, for example:
    -- highlight = "Comment",
    -- prefix = "» ",
  }
)

-- Enable inlay hints on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint(args.buf, true)
    end
  end,
})

lspconfig.ocamllsp.setup({})
