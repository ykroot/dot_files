require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- Tabs and indentation (for 42 Norminette)
vim.opt.expandtab = false  -- use real tabs instead of spaces
vim.opt.tabstop = 4        -- show a tab as 4 spaces
vim.opt.shiftwidth = 4     -- indent width
vim.opt.softtabstop = 4    -- makes <Tab> and <BS> behave properly
vim.g.user42 = "ysenhaji"  -- replace with your 42 username
vim.g.mail42 = "marvin@42.fr"
vim.opt.clipboard = "unnamedplus"

-- Ensure italics work in nvim
vim.opt.more = false

-- "Sane Defaults"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
-- Make whitespace visible
-- vim.opt.list = true
-- vim.opt.listchars = {
--  tab = '→ ',
--  space = '·',
--  trail = '•',
--}

