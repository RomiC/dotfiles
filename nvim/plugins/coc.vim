" Don't re-render coc modal each time
let g:coq_settings = { 'display.pum.fast_close': v:false }
" Hide icons in coc modal
let g:coq_settings = { 'display.icons.mode': 'none' }
" Pre-select first item
let g:coq_settings = { 'coq_settings.keymap.pre_select': v:true }
" Re-map bigger preview
let g:coq_settings = { 'coq_settings.keymap.bigger_preview': '<Tab>' }

" use <c-space>for trigger completion
inoremap <silent><expr> <M-space> coc#refresh()
" navigate throught the list
inoremap <silent><expr> <C-j> pumvisible() ? '<C-n>' : '<C-j>'
inoremap <silent><expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'
" complete on TAB
inoremap <silent><expr> <Tab> pumvisible() ? (complete_info(['selected']).selected == -1 ? '<C-E><CR>' : '<C-Y>') : '<CR>'
