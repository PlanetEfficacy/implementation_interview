class Categorizer
  attr_reader :shop
  def initialize(shop)
    @shop = shop
  end

  def assign_category!
    if shop.prefix == "ls1"
      shop.category = "#{shop.prefix} #{shop.size}"
    elsif shop.prefix == "ls2"
      shop.category = "#{shop.prefix} #{shop.small_or_large}"
    else
      shop.category = "other"
    end
  end

end
