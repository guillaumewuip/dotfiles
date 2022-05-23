-- installing packer if not present
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/*.lua source <afile> | PackerCompile
  augroup end
]]

return require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    require 'base'
    require 'input'
    require 'interface'
    require 'movement'
    require 'completion'
    require 'search'
    require 'syntax'
    require 'undo'
    require 'test'

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
