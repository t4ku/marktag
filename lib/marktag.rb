require "marktag/version"
require "redcarpet"

module MarkTag
  # Your code goes here...
  class Runner
    def initialize(parser,renderer)

    end
  end

  module ParserProxy
    class HeaderProxy
      class <<self
        attr_accessor :headers
        def init_document
          @headers = []
        end

        def push(header_args)
          @headers.push(header_args)
        end
      end
    end

    # 
    # Redcarpet::Render::HTML
    #
    # https://github.com/vmg/redcarpet
    # How to extend the redcarpet 2 Markdown library?
    # http://dev.af83.com/2012/02/27/howto-extend-the-redcarpet2-markdown-lib.html

    class HeaderFilter < Redcarpet::Render::HTML
       def header(header,header_level)
         unless @proxy
           @proxy = HeaderProxy
           @proxy.init_document
         end
         @proxy.push([header,header_level])
         # unless we want html output, we don't have to return anything
         nil
       end

       # RedCarpet Post-process hook
       def postprocess(doc)
         Renderer.new.render(@proxy.headers)
       end
    end
  end

  class Renderer

    def render(headers)
      tag = ""
      headers.each_with_index do |header,idx|
        level = header.last
        name  = header.first
        tag += "header lib/marktag /^#{name}$/ header header:#{name}\n"
      end
      return tag
    end

  end
end
