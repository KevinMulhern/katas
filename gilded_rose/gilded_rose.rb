class GildedRose
  def initialize(items)
    @items = items.map { |item| item_mapper(item) }
  end

  def update_quality()
    @items.each do |item|
      item.set_quality
      item.set_sell_in
    end
  end

  private

  def item_mapper(item)
    {
      "Aged Brie" => AgedBrie.new(item),
      "Sulfuras, Hand of Ragnaros" => Sulfuras.new(item),
      "Backstage passes to a TAFKAL80ETC concert" => BackstagePasses.new(item),
      "Conjured" => Conjured.new(item)
    }.fetch(item.name, Normal.new(item))
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class AgedBrie
  def initialize(item)
    @item = item
  end

  def set_quality
    return if @item.quality >= 50

    @item.quality += 1
    @item.quality += 1 if @item.sell_in <= 0
  end

  def set_sell_in
    @item.sell_in -= 1
  end

end

class Sulfuras
  def initialize(item)
    @item = item
  end

  def set_quality
  end

  def set_sell_in
    @item.sell_in -= 0
  end
end

class BackstagePasses
  def initialize(item)
    @item = item
  end

  def set_quality
    return if @item.quality >= 50 || @item.quality <= 0

    @item.quality += 1
    @item.quality += 1 if @item.sell_in <= 10
    @item.quality += 1 if @item.sell_in <= 5
    @item.quality -= @item.quality if @item.sell_in <= 0
  end

  def set_sell_in
    @item.sell_in -= 1
  end
end

class Normal
  def initialize(item)
    @item = item
  end

  def set_quality
    return if @item.quality <= 0

    @item.quality -= 1
    @item.quality -= 1 if @item.sell_in < 0
  end

  def set_sell_in
    @item.sell_in -= 1
  end
end

class Conjured
  def initialize(item)
    @item = item
  end

  def set_quality
    return if @item.quality >= 50 || @item.quality <= 0

    @item.quality -= 2
    @item.quality -= 2 if @item.sell_in <= 0
  end

  def set_sell_in
    @item.sell_in -= 1
  end
end
