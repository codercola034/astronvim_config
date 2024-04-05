vim.opt.wrap = true

vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.definition()<cr>", { silent = true })
vim.keymap.set("n", "<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", { silent = true })
vim.keymap.set("n", "<leader>s", "<cmd>belowright split | lua vim.lsp.buf.definition()<cr>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>wa<cr>", { silent = true })

return {
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local theme = {
        fill = 'TabLineFill',
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      require('tabby.tabline').set(function(line)
        return {
          {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep('', hl, theme.fill),
              tab.is_current() and '' or '󰆣',
              tab.number(),
              tab.name(),
              tab.close_btn(''),
              line.sep('', hl, theme.fill),
              hl = hl,
              margin = ' ',
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep('', theme.win, theme.fill),
              win.is_current() and '' or '',
              win.buf_name(),
              line.sep('', theme.win, theme.fill),
              hl = theme.win,
              margin = ' ',
            }
          end),
          {
            line.sep('', theme.tail, theme.fill),
            { '  ', hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "lua",
          "python",
          "query",
          "vim",
          "vimdoc",
          "json",
          "typescript",
          "go",
          "gosum",
          "gomod",
          "prisma",
          "tsx",
          "html",
          "css",
          "java",
          -- "javascript",
        }
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require "telescope.actions"
      require("telescope").setup({
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
          },
          n = { q = actions.close },
        }
      })
    end,
  },
  {
    'vim-test/vim-test',
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>dn", "<cmd>TestNearest -v<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { silent = true })
    end,

  },
  {
    'christoomey/vim-tmux-navigator',
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      require("dap-vscode-js").setup({
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      })
      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          }
        }
      end
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    autoStart = true,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<c-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
}
