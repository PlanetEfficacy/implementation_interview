class Shop < ApplicationRecord
  def self.postal_codes
    all.pluck(:post_code).uniq
  end

  def self.unique_categories
    all.pluck(:category).uniq.sort
  end

  def prefix
    standard_code? ? get_standard_code : "other"
  end

  def self.percentile_50
    median(where("post_code LIKE ?", "%LS2%").order(:chairs).pluck(:chairs))
  end

  def small_or_large
    chairs < Shop.percentile_50 ? "small" : "large"
  end

  def size
    return "small" if chairs < 10
    return "large" if chairs >= 100
    return "medium" if chairs >= 10
  end

  def self.export_small_street_cafes
    CSV.generate do |csv|
      csv << column_names
      Shop.where("category LIKE ?", "%small%").order(:name).each do |shop|
        csv << shop.attributes.values_at(*column_names)
        shop.destroy
      end
    end
  end

  private
    def standard_code?
      get_standard_code == "ls1" || get_standard_code == "ls2"
    end

    def get_standard_code
      post_code.split(" ").first.downcase
    end

    def self.median(array)
      index = 0.5 * array.length
      if index % 1 == 0
        (array[index - 1] + array[index]) / 2.0
      else
        array[index.ceil - 1]
      end
    end
end
