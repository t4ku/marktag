# Marktag

## What is this program for

Add markdown support for Vim Tagbar plugin.
It generates ctags file for markdown document. 

## About Ctags and Vim Tagbar  plugin

Tagbar is a vim plugin that helps navigating within file
using ctags. Since Tagbar can be conigured to use different 
program to generate tag files, we just need to generate tag file
Tabgar is happy with.

lushtag (Haskell support for Tagbar)
[plugin/tagbar-haskell.vim](https://github.com/bitc/lushtags/blob/master/plugin/tagbar-haskell.vim)

```
if executable('lushtags')
    let g:tagbar_type_haskell = {
        \ 'ctagsbin' : 'lushtags',
        \ 'ctagsargs' : '--ignore-parse-error --',
        \ 'kinds' : [
            \ 'm:module:0',
            \ 'e:exports:1',
            \ 'i:imports:1',
            \ 't:declarations:0',
            \ 'd:declarations:1',
            \ 'n:declarations:1',
            \ 'f:functions:0',
            \ 'c:constructors:0'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'd' : 'data',
            \ 'n' : 'newtype',
            \ 'c' : 'constructor',
            \ 't' : 'type'
        \ },
        \ 'scope2kind' : {
            \ 'data' : 'd',
            \ 'newtype' : 'n',
            \ 'constructor' : 'c',
            \ 'type' : 't'
        \ }
    \ }
endif
```

See more on [Support for additional types](https://github.com/majutsushi/tagbar/wiki)

~/.ctags
```
--langdef=markdown
--langmap=markdown:.md.mdown.mkdown.markdown
--regex-markdown=/^#[ \t]+(.*)/\1/h,Heading_L1/
--regex-markdown=/^##[ \t]+(.*)/\1/i,Heading_L2/
--regex-markdown=/^###[ \t]+(.*)/\1/k,Heading_L3/
```

~/.vimrc
```
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }
```

```
'marktag'  -f -  --format=2  --excmd=pattern  --fields=nksSa  --extra=  --sort=yes  --language-force=markdown --markdown-kinds=h  '/Users/t4ku/Documents/proj/marktag/README.md'
```

## Install

    gem 'marktag'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marktag

## Usage

TODO: Write usage instructions here



### Tagbar

[Tagbar](http://majutsushi.github.com/tagbar/)




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
