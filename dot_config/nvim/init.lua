local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Options
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.expandtab = true
vim.opt.matchtime = 1
vim.opt.mouse = "n"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.updatetime = 100

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- WSL Clipboard
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

vim.keymap.set("v", "<leader>y", '"*y')

vim.keymap.set("n", "<leader>t", function()
	vim.diagnostic.open_float(nil, { focus = false })
end)

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F3>", ":noh<CR>")
vim.keymap.set("n", "<leader>st", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)

local filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
}

vim.keymap.set("n", "<leader>oi", function()
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	if not vim.tbl_contains(filetypes, buf_ft) then
		return
	end
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	})
end)

vim.keymap.set("n", "<leader>ff", function()
	local formatted = require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	if not formatted then
		vim.lsp.buf.format()
	end
end)

require("lazy").setup("plugins")
