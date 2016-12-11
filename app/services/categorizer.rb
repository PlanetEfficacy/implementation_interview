class Categorizer
  attr_reader :shop
  def initialize(shop)
    @shop = shop
  end

  def assign_category!
    if shop.prefix == "ls1"
      shop.update(category: "#{shop.prefix} #{shop.size}")
    elsif shop.prefix == "ls2"
      puts "Processing shop #{shop.id} #{shop.name}"
      puts "shop prefix = #{shop.prefix}"
      puts "shop small or large = #{shop.small_or_large}"
      puts "shop category was ##{shop.category}"
      shop.update(category: "#{shop.prefix} #{shop.small_or_large}")
      puts "shop category was is #{shop.category}"
    else
      shop.update(category: "other")
    end
  end

end
