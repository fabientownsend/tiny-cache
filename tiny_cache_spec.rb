require_relative 'tiny_cache'

RSpec.describe TinyCache do
  let(:cache) { TinyCache.new(2) }

  it "returns the value of an existing element" do
    cache.add_element('tag', 'value')
    expect(cache.element('tag')).to eq('value')
  end

  it "returns nil when the element doesn't exist" do
    expect(cache.element('tag')).to eq(nil)
  end

  it "override the least hit element when it's the last element added" do
    cache.add_element('tag1', 'value')
    cache.add_element('tag2', 'value')

    1.times { cache.element('tag1') }
    0.times { cache.element('tag2') }

    cache.add_element('tag3', 'value')

    expect(cache.element('tag2')).to eq(nil)
  end

  it "override the least hit element when it's the first element added" do
    cache.add_element('tag2', 'value')
    cache.add_element('tag1', 'value')

    0.times { cache.element('tag1') }
    1.times { cache.element('tag2') }

    cache.add_element('tag3', 'value')

    expect(cache.element('tag1')).to eq(nil)
  end

  it "add an existing element do not override the least hit element" do
    cache.add_element('tag1', 'value')
    cache.add_element('tag2', 'value')

    1.times { cache.element('tag1') }
    0.times { cache.element('tag2') }

    cache.add_element('tag1', 'value')

    expect(cache.element('tag2')).to eq('value')
  end
end
