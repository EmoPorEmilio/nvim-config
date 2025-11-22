local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    { import = "plugins" },

    {
      "nvim-mini/mini.nvim",
      version = "*",
      lazy = false,
      priority = 1000,
      config = function()
        require("mini.base16").setup({
          palette = {
            base00 = "#1D272E", -- bg-400: Canvas
            base01 = "#24313a", -- bg-300: Status Bar
            base02 = "#293E4B", -- bg-200: Selection Highlight
            base03 = "#4F6D85", -- primary-700: Comments (Dark Blue-Grey)
            base04 = "#58748B", -- primary-600: Line Nrs / Cursor
            base05 = "#C0C6CA", -- gray-100: Default Code
            base06 = "#D9F2FF", -- primary-100: Light Text
            base07 = "#FFFFFF", -- white: Highlights

            base08 = "#75ABC7", -- primary-500 (Variables)
            base0D = "#75ABC7", -- primary-500 (Functions - Matching Logic)

            base0E = "#DF5C9A", -- accent-500 (Keywords)
            base09 = "#FF88C0", -- accent-300 (Booleans/Numbers)

            base0B = "#D0E9F5", -- primary-200 (Strings)

            base0A = "#FFFFFF", -- white (Classes/Types)

            base0C = "#A2AEB4", -- gray-200 (Regex/Escape)
            base0F = "#4F6D85", -- Deprecated (Hide)
          },
        })

        -- Apply Custom Overrides
        local highlights = {
          Search = { bg = "#DF5C9A", fg = "#FFFFFF", bold = true },
          IncSearch = { bg = "#FF88C0", fg = "#1D272E" },
          Comment = { fg = "#4F6D85", italic = true },
          String = { fg = "#D0E9F5" },
          LineNr = { fg = "#4C6477" },
          CursorLineNr = { fg = "#DF5C9A", bold = true },
        }

        for group, settings in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, settings)
        end
      end,
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "minischeme" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
