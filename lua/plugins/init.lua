return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

 {
  "saifulapm/neotree-file-nesting-config",
  dependencies = { "nvim-neo-tree/neo-tree.nvim" },

  config = function()
    local ok, neotree = pcall(require, "neo-tree")
    if not ok then return end

    local ok2, nesting = pcall(require, "neotree-file-nesting-config")
    if not ok2 then return end

    neotree.setup({
      -- 1. Move nesting rules into the filesystem block
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        nesting_rules = nesting.nesting_rules, 
      },
      -- 2. Force icons to be empty strings globally
      default_component_configs = {
        indent = {
          with_markers = false, -- Removes the vertical lines for an even cleaner look
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "",
            renamed   = "",
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          }
        },
      },
    })
  end,
  },


  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },


-- 42 Header & Norminette (using MoulatiMehdi repo)
{
  "https://github.com/MoulatiMehdi/42norm.nvim",
  event = "VeryLazy",
  config = function()
    local ok, norm = pcall(require, "42norm")
    if not ok then
      vim.notify("42norm.nvim not found", vim.log.levels.WARN)
      return
    end

    ------------------------------------------------------------------
    -- Plugin setup (NO automatic behavior)
    ------------------------------------------------------------------
    norm.setup({
      header_on_save = false,
      format_on_save = false,
      liner_on_change = false,
      inline = false,
    })

    ------------------------------------------------------------------
    -- MASTER TOGGLE (OFF by default)
    ------------------------------------------------------------------
    vim.g.norm42_enabled = false
    vim.diagnostic.disable()

    local function enable_42()
      vim.g.norm42_enabled = true
      vim.diagnostic.enable()
      print("󰱒 42 tools ENABLED")
    end

    local function disable_42()
      vim.g.norm42_enabled = false
      vim.diagnostic.disable()
      vim.diagnostic.reset(nil, 0)
      print("󰱒 42 tools DISABLED")
    end

    -- <leader>1 = enable / disable EVERYTHING
    vim.keymap.set("n", "<leader>1", function()
      if vim.g.norm42_enabled then
        disable_42()
      else
        enable_42()
      end
    end, { desc = "Toggle 42 tools" })

    ------------------------------------------------------------------
    -- HEADER (manual only)
    ------------------------------------------------------------------
    vim.keymap.set("n", "<leader>3", function()
      if not vim.g.norm42_enabled then
        print("42 tools are disabled")
        return
      end
      norm.stdheader()
    end, { desc = "Insert 42 header", noremap = true, silent = true })

    ------------------------------------------------------------------
    -- NORMINETTE (manual only)
    ------------------------------------------------------------------
    vim.keymap.set("n", "<leader>N", function()
      if not vim.g.norm42_enabled then
        print("42 tools are disabled")
        return
      end
      norm.check_norms()
    end, { desc = "Run Norminette (manual)" })

    ------------------------------------------------------------------
    -- FORMAT (optional)
    ------------------------------------------------------------------
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
