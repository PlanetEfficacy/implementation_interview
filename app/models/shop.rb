class Shop < ApplicationRecord
  def self.postal_codes
    all.pluck(:post_code).uniq
  end

  def self.count_by_post(code)
    where(post_code: code).count
  end

  def self.chairs_by_post(code)
    where(post_code: code).sum(:chairs)
  end

  def self.percent_chairs_at_post(code)
    (chairs_by_post(code).to_f / sum(:chairs) * 100)
  end

  def self.place_with_max_chairs_at_post(code)
    find_by(chairs: maximum(:chairs))
  end

  def self.max_chairs_at_post(code)
    where(post_code: code).maximum(:chairs)
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
