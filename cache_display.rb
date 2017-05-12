require 'io/console'
require 'colorize'

class CacheDisplay
  def initialize(width = IO.console.winsize[1])
    @width = width
    @result = ""
  end

  def add_separator_top
    @result << "┌" << line << "┐\n"
  end

  def add_separator_down
    @result << "└" << line << "┘\n"
  end

  def add_separator
    @result << pipe << line << pipe << "\n"
  end

  def persentage(pers, color = :default)
    width = (pers * @width / 100)
    percentage = " #{pers} % ".center(width, "█")
    @result << percentage.colorize(color) << "\n" if pers != 0
  end

  def add_content(arr, font_color = :default)
    size = (@width - 2 - (arr.size - 1)) / arr.size
    @result << pipe

    arr.each_with_index do |word, index|
      @result << (word.to_s.center(size, " ")).white

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
    "│".blue
  end

  def dash
    "─".blue
  end

  def line
    (dash * (@width - 2))
  end
end
