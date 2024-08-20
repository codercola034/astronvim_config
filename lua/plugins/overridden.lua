return {
    {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    config = function()
      require("neo-tree").setup({
        event_handlers = {

          {
            event = "file_open_requested",
            handler = function()
              -- auto close
              -- vimc.cmd("Neotree close")
              -- OR
              require("neo-tree.command").execute({ action = "close" })
            end
          },
        }
      })
    end,
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
