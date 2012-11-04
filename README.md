# Marktag

## What is this program for

This is to hadd markdown support for Vim Tagbar plugin.
It generates ctags file for markdown document. 

![tagbar](https://github.com/t4ku/marktag/raw/master/scrennshot.png "screenshot")

## About Ctags and Vim Tagbar  plugin

Tagbar is a vim plugin that helps navigating within file
using ctags. Currently, Tagbar support markdown file through ctags language definition.
And it doesn't support nesting headers.

~/.ctags
```
--langdef=markdown
--langmap=markdown:.mkd
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
See [Support for additional types](https://github.com/majutsushi/tagbar/wiki)

Since Tagbar can be conigured to use different 
program to generate tag files, I made this script to 
generate tag file Tabgar is happy with.

## Install

Install the gems.

```
    $ gem install marktag
```

Add following in your ~/.vimrc

```
if executable('marktag')
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'ctagsbin' : 'marktag',
        \ 'kinds' : [
            \ 'h:header'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'h' : 'header'
        \  },
        \ 'scope2kind' : {
            \ 'header' : 'h'
        \ }
    \ }
end
```

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
