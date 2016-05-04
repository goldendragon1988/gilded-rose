class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      check_category(item)
    end
  end

  def check_category(item)
    name = item_name(item)
    case true
      when name.include?('sulfuras')
        the_legendary(item)
      when name.include?('aged brie')
        the_reverse(item)
      when name.include?('backstage passes')
        the_concert(item)
      when name.include?('conjured')
        the_flash(item)
      else
        the_ordinary(item)
    end
  end

  def the_legendary(item)
    item.quality = 80
  end

  def the_reverse(item)
    minus_sell_in(item)
    item.sell_in > 0 ? (plus_quality(item)) : (2.times{plus_quality(item)})
  end

  def the_flash(item)
    minus_sell_in(item)
    item.sell_in > 0 ? 2.times{minus_quality(item)} : 4.times{minus_quality(item)}
  end

  def the_concert(item)
    minus_sell_in(item)
    case true
    when item.sell_in <= 0
      item.quality = 0
    when item.sell_in <= 5
      3.times{plus_quality(item)}
    when item.sell_in <= 10
      2.times{plus_quality(item)}
    else
      plus_quality(item)
    end
  end

  def the_ordinary(item)
    minus_sell_in(item)
    item.sell_in > 0 ? (minus_quality(item)) : (2.times{minus_quality(item)})
  end

  def plus_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def minus_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def minus_sell_in(item)
    item.sell_in -= 1 if item.sell_in > 0
  end

  def item_name(item)
    item.name.downcase
  end
end
