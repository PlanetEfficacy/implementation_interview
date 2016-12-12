class ShopAnalyzer
  attr_reader :post_code
  def initialize(post_code)
    @post_code = post_code
  end

  def self.postal_codes
    Shop.all.pluck(:post_code).uniq
  end

  def shop_count
    Shop.where(post_code: post_code).count
  end

  def total_chairs
    Shop.where(post_code: post_code).sum(:chairs)
  end

  def percent_chairs
    (total_chairs.to_f / Shop.all.sum(:chairs) * 100)
  end

  def place_with_max_chairs
    Shop.find_by(chairs: Shop.all.maximum(:chairs))
  end

  def max_chairs
    Shop.where(post_code: post_code).maximum(:chairs)
  end
end
