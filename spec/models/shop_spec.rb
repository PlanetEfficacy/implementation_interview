require 'rails_helper'

RSpec.describe Shop, type: :model do
  it "gets unique postal_codes" do
    create(:shop, post_code: "1")
    create(:shop, post_code: "2")

    expect(Shop.postal_codes).to eq(["1","2"])
  end

  it "gets unique categories" do
    create(:shop, category: "1")
    create(:shop, category: "2")

    expect(Shop.unique_categories).to eq(["1","2"])
  end

  it "has a prefix" do
    shop_1 = create(:shop, post_code: "LS1 XXX")
    shop_2 = create(:shop, post_code: "LS2 XXX")
    shop_3 = create(:shop, post_code: "LS7 XXX")
    shop_4 = create(:shop, post_code: "LS10 XXX")

    expect(shop_1.prefix).to eq("ls1")
    expect(shop_2.prefix).to eq("ls2")
    expect(shop_3.prefix).to eq("other")
    expect(shop_4.prefix).to eq("other")
  end

  it "has a size" do
    shop_1 = create(:shop, chairs: 9)
    shop_2 = create(:shop, chairs: 10)
    shop_3 = create(:shop, chairs: 100)

    expect(shop_1.size).to eq("small")
    expect(shop_2.size).to eq("medium")
    expect(shop_3.size).to eq("large")
  end

  it "it has a 50th percentile for LS2" do
    create_10_LS2_shops
    create_1_LS1_shop

    expect(Shop.percentile_50).to eq(35.5)
  end

  it "is small or large based on percentile" do
    create_10_LS2_shops
    create_1_LS1_shop

    small_shops.each { |shop| expect(shop.small_or_large).to eq("small") }
    large_shops.each { |shop| expect(shop.small_or_large).to eq("large") }
  end

  def create_1_LS1_shop
    create(:shop, post_code: "LS1 XXX", chairs: 10)
  end
end
