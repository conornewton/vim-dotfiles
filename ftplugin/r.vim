" Settings for R scripts

" Execture the current r script
nmap <leader>rr :AsyncRun -mode=term -pos=right Rscript %<CR>
nmap <leader>pl :AsyncRun evince ./Rplots.pdf<CR>

" Surrounds current line with print command
" Combine into a single command
let @p = "\<ESC>0iprint(\<ESC>A)\<ESC>"
let @o = "\<ESC>0dwx\<ESC>$F)x\<ESC>"
