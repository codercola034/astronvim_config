return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      source_selector = {
        winbar = false,
        statusline = false
      },
      window = {
        position = "left",
        width = 50,
      },
      filesystem= {
        filtered_items = {
          hide_hidden = false,
          hide_gitignored = false,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree").close_all()
          end
        },
      },
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme solarized-osaka")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      opts.mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        },
        n = { q = actions.close },
      }
    end,
  },
  {
    'vim-test/vim-test',
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>dn", "<cmd>TestNearest -v<cr>", { silent = true })
      vim.keymap.set("n", "<leader>dl", "<cmd>TestLast<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { silent = true })
      -- vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { silent = true })
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
}
