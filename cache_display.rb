require 'io/console'
require 'colorize'

class CacheDisplay
  def initialize(width = IO.console.winsize[1])
    @width = width
    @result = ""
  end

  def addSeparator
    @result << pipe
    @result << ("-" * (@width - 2))
    @result << pipe << "\n"
  end

  def addContent(arr)
    margin = 2
    size_little_window = (@width - margin) / arr.size

    @result += pipe
    arr.each_with_index do |s, index|
      @result += s.to_s.center(size_little_window - 1, " ")

      if index == arr.size - 1
        @result += " " * (@width - size_little_window * arr.size - 1)
      else
        @result += pipe
      end
    end
    @result << pipe << "\n"
  end

  def addContentV2(arr)
    size = (@width - 2 - (arr.size - 1)) / arr.size
    @result << pipe

    arr.each_with_index do |c, index|
      @result << c.center(size, " ")

      if (2 + arr.size - 1 + size * arr.size != @width) && index == arr.size - 1
        @result << " " * (@width - (2 + arr.size - 1 + size * arr.size))
      end
      @result << pipe
    end

    @result += "\n"
  end

  def build
    temp = @result
    @result = ""
    temp
  end

  private

  def pipe
    "|"
  end
end
