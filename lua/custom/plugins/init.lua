-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Custom settings that override defaults
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  -- Guess indent configuration with custom options
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      auto_cmd = true,
      override_editorconfig = false,
      on_space_options = {
        expandtab = true,
        tabstop = 2,
        shiftwidth = 2,
        softtabstop = 2,
      },
    },
  },

  -- Todo comments highlighting
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = ' ',
          color = 'error',
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
      gui_style = {
        fg = 'NONE',
        bg = 'BOLD',
      },
      merge_keywords = true,
      highlight = {
        multiline = true,
        multiline_pattern = '^.',
        multiline_context = 10,
        before = '',
        keyword = 'wide_bg',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#FF5370' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FFCB6B' },
        info = { 'DiagnosticInfo', '#82AAFF' },
        hint = { 'DiagnosticHint', '#C3E88D' },
        default = { 'Identifier', '#BB80B3' },
        test = { 'Identifier', '#F78C6C' },
      },
    },
    config = function(opts)
      require('todo-comments').setup(opts)
      
      -- Add telescope search keymap for todos
      vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[S]earch [T]odos' })
    end,
  },
}
