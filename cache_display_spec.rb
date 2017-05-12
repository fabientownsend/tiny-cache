require_relative 'cache_display'
require 'colorize'

RSpec.describe CacheDisplay do
  it "even separator" do
    cache_display = CacheDisplay.new(10)
    cache_display.add_separator

    expect(cache_display.build()).to eq("│────────│\n")
  end

  it "odd separator" do
    cache_display = CacheDisplay.new(11)
    cache_display.add_separator

    expect(cache_display.build()).to eq("│─────────│\n")
  end

  it "centers a odd element in odd width" do
    cache_display = CacheDisplay.new(5)
    cache_display.add_content(["a"])

    expect(cache_display.build()).to eq("│ a │\n")
  end

  it "centers a even element in odd width" do
    cache_display = CacheDisplay.new(5)
    cache_display.add_content(["aa"])

    expect(cache_display.build()).to eq("│aa │\n".colorize(:default))
  end

  it "centers a odd element in even width" do
    cache_display = CacheDisplay.new(6)
    cache_display.add_content(["a"])

    expect(cache_display.build()).to eq("│ a  │\n".colorize(:default))
  end

  it "centers a even element in even width" do
    cache_display = CacheDisplay.new(6)
    cache_display.add_content(["aa"])

    expect(cache_display.build()).to eq("│ aa │\n".colorize(:default))
  end

  it "even elements content even width odd" do
    cache_display = CacheDisplay.new(11)
    cache_display.add_content(["aa", "bb"])

    expect(cache_display.build()).to eq("│ aa │ bb │\n".colorize(:default))
  end

  it "even elements content even with even" do
    cache_display = CacheDisplay.new(12)
    cache_display.add_content(["aa", "bb"])

    expect(cache_display.build()).to eq("│ aa │ bb  │\n".colorize(:default))
  end
end
