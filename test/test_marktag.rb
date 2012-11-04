require "marktag"
require "minitest/autorun"


class HeaderFilterTest < MiniTest::Unit::TestCase
  def test_filter_capture_all_headers
    md = Redcarpet::Markdown.new(MarkTag::ParserProxy::HeaderFilter)

    md_text = <<-EOS
first header
============

second header
------------

### third header
EOS

    md_tag = <<-EOS
first_header lib/marktag.rb /^first header$/;" h
second_header lib/marktag.rb /^second header$/;" h header:first_header
third_header lib/marktag.rb /^third header$/;" h header:first_header:second_header
EOS

   # This is the tag file of this ruby script
   # 
   # Document  lib/marktag.rb  /^  module Document$/;" m class:MarkTag
   # Element lib/marktag.rb  /^    class Element$/;" c class:MarkTag.Document
   # MarkTag lib/marktag.rb  /^module MarkTag$/;"  m
   # ...
   # 
   # In the case of 
   # Markdown Title > Tutorial > ctags file format
   # 
   # Markdown Title   path/to/markdown  /^Markdown Title$/;" heading
   # Tutorial  path/to/markdown  /^Tutorial$/;" h heading:Markdown Title
   # ctags file format   path/to/markdown  /^ctags file format$/;" h heading:Markdown Title.Tutorial
   # 
   # Exuberant Ctags
   # http://en.wikipedia.org/wiki/Ctags#Exuberant_Ctags_2
   # {tagname}<Tab>{tagfile}<Tab>{tagaddress}[;"<Tab>{tagfield}...]

    assert_equal  md_tag,md.render(md_text)
   end

  def test_headers_with_paragrahs
    md = Redcarpet::Markdown.new(MarkTag::ParserProxy::HeaderFilter)

    md_text = <<-EOS
first header
============

first paragraph

second header
------------

second paragraph

### third header

third paragraph

EOS

    md_tag = <<-EOS
first_header lib/marktag.rb /^first header$/;" h
second_header lib/marktag.rb /^second header$/;" h header:first_header
third_header lib/marktag.rb /^third header$/;" h header:first_header:second_header
EOS

    assert_equal md_tag,md.render(md_text)
  end

  def test_invalid_sequence_of_headers
  end
end

class RendererTest < MiniTest::Unit::TestCase
  def setup
  end
end
