return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- NvimTree: clean tree, arrows, trailing /, root path
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = false,
              modified = false,
              diagnostics = false,
              bookmarks = false,
            },
          },
          add_trailing = true,
          indent_markers = { enable = false },
          highlight_git = false,
          highlight_opened_files = "none",
          highlight_modified = "none",
          root_folder_label = ":~",
          indent_width = 2,
        },
        view = { width = 30 },
      })

      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = nil })
      vim.api.nvim_set_hl(0, "NvimTreeFolderArrow", { fg = "#bb9af7", bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#9d7cd8" })
      vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeFile", { fg = "#a9b1d6" })
      vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "NvimTreeFileNew", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "NvimTreeFileExt", { fg = "#565f89", italic = true })

      vim.keymap.set("n", "<leader><Enter>", function()
        local api = require("nvim-tree.api")
        local node = api.tree.get_node_under_cursor()
        if node and node.type == "directory" then
          api.tree.change_root_to_node(node)
          vim.cmd.cd(node.absolute_path)
        end
      end, { desc = "Set folder as tree root and cwd" })
    end,
  },

  -- 42 Header & Norminette
  {
    "https://github.com/MoulatiMehdi/42norm.nvim",
    event = "VeryLazy",
    config = function()
      local ok, norm = pcall(require, "42norm")
      if not ok then
        vim.notify("42norm.nvim not found", vim.log.levels.WARN)
        return
      end

      norm.setup({
        header_on_save = false,
        format_on_save = false,
        liner_on_change = false,
        inline = false,
      })

      vim.g.norm42_enabled = false
      vim.diagnostic.disable()

      local function enable_42()
        vim.g.norm42_enabled = true
        vim.diagnostic.enable()
        print("42 tools ENABLED")
      end

      local function disable_42()
        vim.g.norm42_enabled = false
        vim.diagnostic.disable()
        vim.diagnostic.reset(nil, 0)
        print("42 tools DISABLED")
      end

      vim.keymap.set("n", "<leader>1", function()
        if vim.g.norm42_enabled then
          disable_42()
        else
          enable_42()
        end
      end, { desc = "Toggle 42 tools" })

      vim.keymap.set("n", "<leader>3", function()
        if not vim.g.norm42_enabled then
          print("42 tools are disabled")
          return
        end
        norm.stdheader()
      end, { desc = "Insert 42 header", noremap = true, silent = true })

      vim.keymap.set("n", "<leader>N", function()
        if not vim.g.norm42_enabled then
          print("42 tools are disabled")
          return
        end
        norm.check_norms()
      end, { desc = "Run Norminette (manual)" })

      vim.keymap.set("n", "<C-f>", function()
        if not vim.g.norm42_enabled then
          print("42 tools are disabled")
          return
        end
        norm.format()
      end, { desc = "Format (42norm)", noremap = true, silent = true })
    end,
  },
}
