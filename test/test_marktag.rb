require "marktag"
require "minitest/autorun"


class HeaderFilterTest < MiniTest::Unit::TestCase

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

   # Exuberant Ctags
   # http://en.wikipedia.org/wiki/Ctags#Exuberant_Ctags_2
   # {tagname}<Tab>{tagfile}<Tab>{tagaddress}[;"<Tab>{tagfield}...]

    md_tag = <<-EOS
first header\tlib/marktag.rb\t/^#\\+\\s\\*first header$/;"\th
second header\tlib/marktag.rb\t/^#\\+\\s\\*second header$/;"\th\theader:first header
third header\tlib/marktag.rb\t/^#\\+\\s\\*third header$/;"\th\theader:first header.second header
EOS

    tag_renderer = md.render(md_text)
    assert_equal md_tag,tag_renderer.render('lib/marktag.rb')
  end

  def test_invalid_sequence_of_headers
  end
end

class RendererTest < MiniTest::Unit::TestCase
  def setup
  end
end
