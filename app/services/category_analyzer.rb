class CategoryAnalyzer
  attr_reader :category
  def initialize(category)
    @category = category
  end

  def shop_count
    Shop.all.where(category: category).count
  end

  def chair_count
    Shop.all.where(category: category).sum(:chairs)
  end
end
