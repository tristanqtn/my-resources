-----------------------------------------------------------
-- Basics
-----------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

-----------------------------------------------------------
-- Wrapped-line friendly movement
-----------------------------------------------------------
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-----------------------------------------------------------
-- Lazy.nvim (plugin manager)
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({

  -------------------------------------------------------
  -- Theme: Dracula
  -------------------------------------------------------
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  -------------------------------------------------------
  -- Statusline
  -------------------------------------------------------
  { "nvim-lualine/lualine.nvim", config = true },

  -------------------------------------------------------
  -- LSP (Python example)
  -------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Neovim 0.11+ (new API)
      if vim.lsp.config then
        vim.lsp.config("pyright", {})
      else
      -- Fallback for older Neovim
        require("lspconfig").pyright.setup({})
      end
    end,
  },

  -------------------------------------------------------
  -- Autocomplete
  -------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -------------------------------------------------------
  -- Telescope (file & text search)
  -------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
  },

  -------------------------------------------------------
  -- Which-key (learning helper)
  -------------------------------------------------------
  { "folke/which-key.nvim", config = true },

  -------------------------------------------------------
  -- Git
  -------------------------------------------------------
  { "tpope/vim-fugitive" },

  -------------------------------------------------------
  -- Buffer line
  -------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
  },

  -------------------------------------------------------
  -- File explorer
  -------------------------------------------------------
  {
    "stevearc/oil.nvim",
    config = true,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  -------------------------------------------------------
  -- Leap (fast navigation)
  -------------------------------------------------------
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
    end,
  },
})

