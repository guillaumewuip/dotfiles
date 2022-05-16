-- installing packer if not present
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  require 'base'
  require 'input'
  require 'interface'
  require 'completion'
  require 'search'
  require 'syntax'
  require 'undo'

  vim.cmd [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost */nvim/lua/*.lua source <afile> | PackerCompile
      autocmd User PackerCompileDone ++once lua print 'PackerCompile done - Restart vim'
    augroup end
  ]]

  if packer_bootstrap then
    require('packer').sync()
  end
end)
