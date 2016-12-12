class Categorizer
  attr_reader :shop
  def initialize(shop)
    @shop = shop
  end

  def assign_category!
    shop.category = ls1_category if ls1?
    shop.category = ls2_category if ls2?
    shop.category = "other" if other?
    shop.save!
  end

  private

    def ls1?
      shop.prefix == "ls1"
    end

    def ls2?
      shop.prefix == "ls2"
    end

    def other?
      !ls1? && !ls2?
    end

    def ls1_category
      "#{shop.prefix} #{shop.size}"
    end

    def ls2_category
      "#{shop.prefix} #{shop.small_or_large}"
    end
end
