" ---- Keybindings ----

" Go To
" - Git
nnoremap  <silent>  gc  :call VSCodeNotify('workbench.view.scm')<CR>
" - GitLens
nnoremap  <silent>  gl  :call VSCodeNotify('gitlens.views.repositories:gitlens.focus')<CR>
" - Problems
nnoremap  <silent>  gp  :call VSCodeNotify('workbench.action.problems.focus')<CR>
" - Search
nnoremap  <silent>  gf  :call VSCodeNotify('workbench.action.findInFiles')<CR>
" - Search&Replace
nnoremap  <silent>  gr  :call VSCodeNotify('workbench.action.replaceInFiles')<CR>
" - Terminal
nnoremap  <silent>  gs  :call VSCodeNotify('workbench.action.terminal.focus')<CR>
" - File explorer
nnoremap  <silent>  ge  :call VSCodeNotify('workbench.view.explorer')<CR>
" - WhichKey
nnoremap  <silent>  <Space>  :call VSCodeNotify('whichkey.show')<CR>

