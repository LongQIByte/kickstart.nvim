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
}
