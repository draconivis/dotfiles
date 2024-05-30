-- "visual" plugins
return {
  { -- startup dashboard
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      --require'alpha'.setup(require'alpha.themes.dashboard'.config)
      require('alpha').setup(require('alphaConf').config)
    end
  },
  { -- Soothing pastel theme for the high-spirited!
    'catppuccin/nvim',
    name = "catppuccin",
    opts = {
      integrations = {
        fidget = true,
        neotree = true,
        noice = true,
        which_key = true,
      }
    },
    config = function()
      -- vim.opt.background = 'light'
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     -- vim.opt.background = 'light'
  --     vim.cmd.colorscheme 'rose-pine-moon'
  --   end,
  -- },
  { -- unintrusive notifications for lsps / linters / formatters
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      }
    }
  },
  { -- inline git blame
    'f-person/git-blame.nvim',
    opts = {
      enabled = false,
      schedule_event = "CursorHold",
      clear_event = "CursorHoldI"
    }
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },

  },
  { -- indentation guides
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        -- theme = "catppuccin",
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  { -- file explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set('n', '<leader>n', function()
        require('neo-tree.command').execute({
          toggle = true
        })
      end, { desc = 'Open [N]eotree' })
      vim.keymap.set('n', '-', function()
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, "r")
          if (f) then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute({
          action = "focus",          -- OPTIONAL, this is the default value
          source = "filesystem",     -- OPTIONAL, this is the default value
          position = "left",         -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true,   -- change cwd without asking if needed
        })
      end, { desc = "Open neo-tree at current file or working directory" }
      );
    end
  },
  { -- vim command line replacement, notifications, and more
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  { -- splits navigation & management
    'mrjones2014/smart-splits.nvim',
    config = function()
      local smspl = require('smart-splits')
      smspl.setup({
        ignored_buftypes = { 'neo-tree', 'dbui' },
      })

      require("which-key").register({
        ["<leader><leader>"] = { name = "Smart Splits Swap Buffer", _ = "which_key_ignore" },
      })

      vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize split left' })
      vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize split down' })
      vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize split up' })
      vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize split right' })
      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move cursor a split left' })
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move cursor a split below' })
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move cursor a split above' })
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move cursor a split right' })
      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left, { desc = 'Swap with left Buffer' })
      vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down, { desc = 'Swap with Buffer below' })
      vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up, { desc = 'Swap with Buffer above' })
      vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right,
        { desc = 'Swap with right Buffer' })
    end
  },
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",
        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sF", function()
        builtin.find_files({ hidden = true, no_ignore = true })
      end, { desc = "[S]earch [F]iles with hidden files" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sG", function()
        builtin.live_grep({ additional_args = { "--hidden", "--no-ignore" } })
      end, { desc = "[S]earch by [G]rep with hidden files" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set("n", "<leader>/", function()
      -- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
      -- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      -- 		winblend = 10,
      -- 		previewer = false,
      -- 	}))
      -- end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set("n", "<leader>s/", function()
      -- 	builtin.live_grep({
      -- 		grep_open_files = true,
      -- 		prompt_title = "Live Grep in Open Files",
      -- 	})
      -- end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      -- vim.keymap.set("n", "<leader>sn", function()
      -- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
      -- end, { desc = "[S]earch [N]eovim files" })
    end,
  },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  { -- quickview of current problems reported by lsps
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  { -- show pending keybinds.
    'folke/which-key.nvim',
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function()
      -- document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      })
    end
  },
}
