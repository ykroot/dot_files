require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Nvim-tree keybindings
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
