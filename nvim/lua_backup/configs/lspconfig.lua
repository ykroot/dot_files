require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd" }
vim.lsp.enable(servers)

-- LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { silent = true })
