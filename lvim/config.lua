vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = false

lvim.log.level = "info"
lvim.format_on_save = {
    enabled = false,
    pattern = "*.lua",
    timeout = 1000,
}

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.colorscheme = "lunar"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.auto_install = true
-- Linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "eslint" },
    {
        command = "flake8",
        args = { "--max-line-length", "99" }
    },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = 'prettierd' },
    { command = "black" },
    { command = "isort" },
}

lvim.plugins = {

    {
        "Pocco81/auto-save.nvim",
        config = function()
          require("auto-save").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
          require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
              RGB = true, -- #RGB hex codes
              RRGGBB = true, -- #RRGGBB hex codes
              RRGGBBAA = true, -- #RRGGBBAA hex codes
              rgb_fn = true, -- CSS rgb() and rgba() functions
              hsl_fn = true, -- CSS hsl() and hsla() functions
              css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
              css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          })
        end,
    },
    {
        "dhruvasagar/vim-table-mode",
    },
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
          vim.cmd "highlight default link gitblame SpecialComment"
          vim.g.gitblame_enabled = 0
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
    },
    {
        "p00f/nvim-ts-rainbow",
    },
    {
        "rmagatti/goto-preview",
        config = function()
          require('goto-preview').setup {
              width = 120, -- Width of the floating window
              height = 25, -- Height of the floating window
              default_mappings = false, -- Bind default mappings
              debug = false, -- Print debug information
              opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
              post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
              -- You can use "default_mappings = true" setup option
              -- Or explicitly set keybindings
              -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
              -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
              -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
          }
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require "lsp_signature".on_attach() end,
    },
    -- {
    --   "turbio/bracey.vim",
    --   cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
    --   run = "npm install --prefix server",
    -- },
    --
    -- { 'wuelnerdotexe/vim-enfocado' }, -- doesn't work w lvim
    --
}

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- add your own keymapping
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- -- Change theme settings
--
--

-- Automatically install missing parsers when entering buffer


--     {
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
