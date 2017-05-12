require_relative 'tiny_cache'
require_relative 'cache_display'
require 'colorize'

def display_current_cache(cache, displayer)
  system("clear")
  new_display(displayer)

  cache.contents.each_with_index do |c, index|
    displayer.add_content(c)

    if index + 1 == cache.contents.size
      displayer.add_separator_down
    else
      displayer.add_separator
    end
  end

  displayer.persentage(cache.pers, :blue)
  puts displayer.build
end

def new_display(displayer)
  displayer.add_separator_top
  displayer.add_content([""])
  displayer.add_content(["Tiny Cache"])
  displayer.add_content([""])
  displayer.add_separator
  displayer.add_content(["Hit", "Tag", "Data"])
  displayer.add_separator
end

def fill_cache(cache, displayer)
  cache.contents.size.times do
    display_current_cache(cache, displayer)

    print "Add page to the cache: "
    page = gets.chomp
    cache.add_element("/#{page}", "page_#{page}")
  end
end

system("clear")
print "Cache size? "
size = gets.to_i
cache = TinyCache.new(size)
displayer = CacheDisplay.new

fill_cache(cache, displayer)

display_current_cache(cache, displayer)

requested_page = nil

5.times do
  if requested_page
    puts "You requested:  #{requested_page}"
  else
    puts "You requested: nothing yet"
  end
  puts

  print "Request a page: "
  requested_page = cache.element(gets.chomp)

  display_current_cache(cache, displayer)
end

print "You will call a new page which will have a cache miss: "
key = gets.chomp
cache.add_element(key, "page_#{key}")

display_current_cache(cache, displayer)
