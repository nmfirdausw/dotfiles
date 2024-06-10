function LoadGitPlugin()
end

vim.api.nvim_command("autocmd User GitDir lua LoadGitPlugin()")

if vim.g.gitdir then
  vim.api.nvim_exec2("doautocmd User GitDir", {})
end
