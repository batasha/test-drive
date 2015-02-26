require 'artii'
require 'rainbow'

module Test
  module Drive
    module Formatter
      COLORS = [
          :red,
          :green,
          :yellow,
          :blue,
          :magenta,
          :cyan,
          :white
      ]

      def print_result(result)
        if result == 'SUCCESS' || result == 'UNSTABLE'
          puts rainbowize '*********************************************************************************************************************************************'
          puts rainbowize Artii::Base.new(font: 'slant').asciify('T E S T - D R I V E N .')
          puts rainbowize '*********************************************************************************************************************************************'
        else
          puts Rainbow(Artii::Base.new.asciify result).red
        end
      end


      def rainbowize(string)
        rainbow_string = ''
        string.length.times { |i| rainbow_string << Rainbow(string[i]).color(COLORS[i % COLORS.length]) }
        rainbow_string
      end
    end
  end
end