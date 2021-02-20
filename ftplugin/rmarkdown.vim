" Compile R markdown files on save
autocmd! BufWritePost *.Rmd :AsyncRun Rscript -e 'library(rmarkdown);render("%", "pdf_document")'

nmap <leader> tm :terminal 
