require "marktag/version"
require "redcarpet"

module MarkTag
  class << self
    def get_renderer
      return Redcarpet::Markdown.new(ParserProxy::HeaderFilter)
    end

    def run(args)
      if args.size > 0
        file = args.last
        if File.exists?(file)
          markdown = File.read(file)
          renderer = get_renderer()
          # get TagRenderer from Redcarpet postprocess hook
          tag_renderer =  renderer.render(markdown)
          # print tag file with given file path
          print tag_renderer.render(file)
        end
      end
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
         TagRenderer.new(@proxy.headers)
       end
    end
  end

  class TagRenderer
    def initialize(headers)
      @headers = headers
    end

    def render(file_path)
      tag = ""
      level_headers = []
      @headers.each_with_index do |header,idx|
        level = header.last - 1
        level_headers[level] = header.first
        name  = header.first

        header_identifier = get_header_identifier(level_headers,level)
        # esq_name = name.gsub(/\s/,"_")
        esq_name = name

        if (header_identifier)
          tag += "#{esq_name}\t#{file_path}\t/^\\.\\*#{name}$/;\"\th\t#{header_identifier}"
        else
          tag += "#{esq_name}\t#{file_path}\t/^\\.\\*#{name}$/;\"\th"
        end

        tag += "\n"
      end
      return tag
    end

    def get_header_identifier(level_headers,target_level)
      if (target_level) == 0
        return nil
      end

      identifiers = []
      (target_level -1).downto(0) do |l|
        identifier = level_headers.values_at(l) != nil  ? level_headers[l] : "none"
        identifiers.push(identifier)
      end

      ctag_class = "header:"
      header_str = identifiers.reverse.map do |i|
        i
        #i.gsub(/\s/,"_")
      end.join "."

      return ctag_class + header_str
    end
  end
end
