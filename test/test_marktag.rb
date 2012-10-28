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
first header lib/marktag.rb /^first header$/;" header header:firstheader
second header lib/marktag.rb /^second header$/;" header header:firstheader:secondheader
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

    assert_equal  "EOS",md.render(md_text)
   end
end

class RendererTest < MiniTest::Unit::TestCase
  def setup
  end
end
