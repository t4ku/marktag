if executable('marktag')
  let g:tagbar_type_markdown = {
    \ 'ctagsbin'  : 'marktag',
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
      \ 'h:Heading'
    \ ]
  \ }
endif
