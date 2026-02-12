-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key first
vim.g.mapleader = " "

-- Setup plugins
require("lazy").setup({
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup {
        mirage = false,
        terminal = true,
        overrides = {
          Normal = { bg = "None" },
          ColorColumn = { bg = "None" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorLine = { bg = "None" },
          CursorColumn = { bg = "None" },
          WhichKeyFloat = { bg = "None" },
          VertSplit = { bg = "None" },
        },
      }
      vim.cmd "colorscheme ayu-dark"
      vim.cmd [[
        highlight CmpItemAbbrMatch guifg=#FFFFFF gui=NONE
        highlight CmpItemAbbrMatchFuzzy guifg=#FFFFFF gui=NONE
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight NormalFloat guibg=NONE ctermbg=NONE
        highlight NvimTreeNormal guibg=NONE ctermbg=NONE
        highlight FloatBorder guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
        highlight LineNr guifg=#585B70
      ]]
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<C-t>", ":Telescope colorscheme<CR>", { silent = true })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local api = require "nvim-tree.api"
      require("nvim-tree").setup {
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = false,
            },
          },
          indent_markers = { enable = false },
          add_trailing = true,
        },
        view = {
          side = "left",
          width = 30,
          signcolumn = "no",
        },
        actions = {
          open_file = { quit_on_open = false },
        },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
          vim.keymap.set("n", "<C-u>", api.tree.change_root_to_parent, opts "Up")
          vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts "Up")
        end,
      }
      vim.opt.fillchars:append { vert = " " }
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

      vim.keymap.set("n", "<leader><CR>", function()
        local node = api.tree.get_node_under_cursor()
        if node and node.type == "directory" then
          api.tree.change_root_to_node(node)
          vim.cmd.cd(node.absolute_path)
        end
      end, { desc = "Set folder as tree root and cwd" })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.api.nvim_set_hl(0, "NvimTreeFolderArrow", { fg = "#bb9af7", bold = true })
          vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#c0caf5" })
          vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#9d7cd8" })
          vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#e0af68", bold = true })
          vim.api.nvim_set_hl(0, "NvimTreeFile", { fg = "#a9b1d6" })
          vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#e0af68" })
          vim.api.nvim_set_hl(0, "NvimTreeFileNew", { fg = "#7aa2f7" })
          vim.api.nvim_set_hl(0, "NvimTreeFileExt", { fg = "#565f89", italic = true })
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        bg = "#15002E",
        fg = "#E5E0F3",
        purple = "#CBA6F7",
        pink = "#F38BA8",
        blue = "#89B4FA",
        cyan = "#94E2D5",
        grey = "#2A0B4A",
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.purple },
          b = { fg = colors.fg, bg = colors.grey },
          c = { fg = colors.fg },
        },
        insert = { a = { fg = colors.bg, bg = colors.blue } },
        visual = { a = { fg = colors.bg, bg = colors.cyan } },
        replace = { a = { fg = colors.bg, bg = colors.pink } },
        inactive = {
          a = { fg = colors.fg, bg = colors.bg },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg },
        },
      }

      require("lualine").setup {
        options = {
          theme = bubbles_theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch" },
          lualine_c = { "%=" },
          lualine_x = {},
          lualine_y = { { "filetype", icons_enabled = false }, { function() return "󰯙" end }, "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree" },
      }
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { pattern = "^:", icon = ">", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "☾", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
          },
        },
        messages = { enabled = true, view = "notify" },
        popupmenu = { enabled = true, backend = "nui" },
        lsp = { hover = { enabled = false }, signature = { enabled = false } },
        presets = { bottom_search = false, command_palette = true, long_message_to_split = true },
      }
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      local show_secret = false

      dashboard.section.header.val = {
        "                                                     ",
        "                                                     ",
        "            󰯙  And this is your sign  󰯙            ",
        "                                                     ",
        "                                                     ",
      }

      vim.keymap.set("n", "s", function()
        if vim.bo.filetype == "alpha" then
          show_secret = not show_secret
          if show_secret then
            dashboard.section.header.val = {
              "                                                     ",
              "            󰯙  And this is your sign  󰯙            ",
              "                                                     ",
              "          to SHUT THE F*** UP and go code            ",
              "                                                     ",
            }
          else
            dashboard.section.header.val = {
              "                                                     ",
              "                                                     ",
              "            󰯙  And this is your sign  󰯙            ",
              "                                                     ",
              "                                                     ",
            }
          end
          alpha.redraw()
        else
          require("leap").leap { target_windows = { vim.fn.win_getid() } }
        end
      end, { desc = "Toggle dashboard secret or leap" })

      dashboard.section.buttons.val = {}
      dashboard.section.footer.val = ""
      dashboard.config.opts.noautocmd = true
      dashboard.opts.layout[1].val = 8
      alpha.setup(dashboard.config)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
      }
      vim.lsp.config.clangd = {
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
      }
      vim.lsp.enable "pyright"
      vim.lsp.enable "clangd"

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { silent = true })

      local border = {
        { "╭", "LspBorder" },
        { "─", "LspBorder" },
        { "╮", "LspBorder" },
        { "│", "LspBorder" },
        { "╯", "LspBorder" },
        { "─", "LspBorder" },
        { "╰", "LspBorder" },
        { "│", "LspBorder" },
      }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
        max_width = 100,
        max_height = 30,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
        max_width = 100,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        window = {
          completion = cmp.config.window.bordered {
            border = "rounded",
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpNormal",
            max_height = 15,
            scrollbar = true,
          },
          documentation = cmp.config.window.bordered {
            border = "rounded",
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpNormal",
          },
        },
        mapping = cmp.mapping.preset.insert {
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        },
        sources = { { name = "nvim_lsp" }, { name = "buffer" } },
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup { direction = "float", float_opts = { border = "curved" } }
      vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { silent = true })
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { silent = true })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup { scope = { enabled = true } }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {
        ensure_installed = { "python", "lua", "c", "cpp", "javascript", "typescript" },
        highlight = { enable = true },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "moulatiMehdi/42norm.nvim",
    config = function()
      require("42norm").setup {
        header_on_save = false,
        format_on_save = false,
        liner_on_change = false,
        inline = false,
      }
      vim.g.norm42_enabled = false
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
})

-- Basic settings
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.mouse = "a"
vim.opt.cursorline = true

-- LSP popup styling
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.cmd [[
      highlight LspBorder guifg=#FFFFFF guibg=NONE
      highlight LspNormal guibg=NONE
    ]]
  end,
})

-- Completion menu styling
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd [[
      highlight CmpItemAbbrMatch guifg=#FFFFFF
      highlight CmpItemAbbrMatchFuzzy guifg=#FFFFFF
      highlight CmpItemKind guifg=#D4D4D4
      highlight CmpItemMenu guifg=#808080
    ]]
  end,
})



-- Make lualine background transparent
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd "hi StatusLine guibg=NONE ctermbg=NONE"
    vim.cmd "hi StatusLineNC guibg=NONE ctermbg=NONE"
    vim.cmd "hi VertSplit guifg=#CBA6F7 guibg=NONE"
    vim.cmd "hi WinSeparator guifg=#CBA6F7 guibg=NONE"
  end,
})
vim.cmd "hi StatusLine guibg=NONE ctermbg=NONE"
vim.cmd "hi StatusLineNC guibg=NONE ctermbg=NONE"
vim.cmd "hi VertSplit guifg=#CBA6F7 guibg=NONE"
vim.cmd "hi WinSeparator guifg=#CBA6F7 guibg=NONE"

vim.opt.fillchars:append { vert = "│", vertleft = "│", vertright = "│", horiz = "─", horizup = "─", horizdown = "─" }
