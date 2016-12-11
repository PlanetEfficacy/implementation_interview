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
    (chairs_by_post(code).to_f / sum(:chairs) * 100).round.to_i
  end

  def self.place_with_max_chairs_at_post(code)
    find_by(chairs: maximum(:chairs))
  end

  def self.max_chairs_at_post(code)
    where(post_code: code).maximum(:chairs)
  end
end
