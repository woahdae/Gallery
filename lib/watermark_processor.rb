module Paperclip
  class Watermark < Thumbnail

    def initialize(file, options = {}, attachment = nil)
       super
       @options = options
       @watermark_path     = options[:watermark_path]
       @watermark_position = options[:watermark_position] || "SouthEast"
       @watermark_offset   = options[:watermark_offset]
     end

    # Processors just need to respond to make
    def make
      file = super

      if @watermark_path
        params = "-gravity #{@watermark_position}"

        if offset = @watermark_offset
          params << " -geometry +#{offset[:x]}+#{offset[:y]}"
        end

        params << " #{@watermark_path} #{file.path} #{file.path}"

        Paperclip.run('composite', params)
      end

      file
    end
  end
end
