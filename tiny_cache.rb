class TinyCache
  def initialize(size = 3)
    @cache = {}
    @cache_size_limit = size
  end

  def add_element(tag, value)
    return if hit?(tag)
    @cache.delete(least_hit_element_tag) if full?
    @cache[tag] = { data: value, hit: 0 }
  end

  def element(tag)
    return unless hit?(tag)
    @cache[tag][:hit] += 1
    @cache[tag][:data]
  end

  def contents
    cache_content + cache_available_spots
  end

  private

  def hit?(tag)
    @cache.key?(tag)
  end

  def full?
    @cache.size >= @cache_size_limit
  end

  def least_hit_element_tag
    tag, = least_hit_element
    tag
  end

  def least_hit_element
    @cache.sort_by { |_, cache_element| cache_element[:hit] }.first
  end

  def cache_content
    @cache.map { |tag, v| [v[:hit], tag, v[:data]] }.sort.reverse
  end

  def cache_available_spots
    Array.new(@cache_size_limit - @cache.size) { ['-', '-', '-'] }
  end
end
