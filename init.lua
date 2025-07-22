vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<C-CR>", "o<Esc>", { silent = true })

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.clipboard = "unnamedplus"

if vim.g.neovide then
	-- vim.o.guifont = "Iosevka Fixed:h15"  -- Default font setting
	-- vim.o.guifont = "JetBrainsMono Nerd Font:h14"
	-- vim.o.guifont = "JetBrains Mono:h14"
	vim.o.guifont = "Roboto Mono:h14"
	vim.g.neovide_opacity = 0
    vim.g.neovide_cursor_animation_length = 0
end

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, noremap = true, silent = true })

-- PROSE WRITING
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.wo.spell = true -- Enable spell checking
		vim.opt.wrap = true -- Enable line wrapping
		vim.wo.linebreak = true -- Break at word boundaries
		vim.opt.linebreak = true -- Break at word boundaries
		vim.opt.breakindent = true -- Indent wrapped lines for readability
		vim.opt.textwidth = 0 -- Disable automatic hard wrapping (newlines)
		vim.opt.wrapmargin = 0 -- Disable margin-based wrapping
	end,
})

-- LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- Add your plugins here
	spec = {
		{ "ronisbr/nano-theme.nvim",
            init = function ()
                vim.o.background = "light"
            end
        },
		{ "NTBBloodbath/doom-one.nvim" },
		{ "folke/tokyonight.nvim" },
		{ "catppuccin/nvim" },
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			config = function()
				require("toggleterm").setup({
					open_mapping = [[<C-`>]], -- Try <C-`> first; fallback to F12 if it doesn't work
					direction = "float",
					float_opts = {
						border = "curved",
					},
					start_in_insert = true,
					shell = "powershell.exe",
				})
			end,
		},
	},
	checker = { enabled = true },
})

vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme nano-theme")
vim.cmd("set cmdheight=0")

-- Enable mouse support
vim.opt.mouse = "a"

-- Enable folding
vim.opt.foldmethod = "syntax" -- or "marker", or "expr"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Start with all folds open

-- Optional: More visible fold column
vim.opt.foldcolumn = "1"

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> feels like when editing
