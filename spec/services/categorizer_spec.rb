require 'rails_helper'

RSpec.describe Categorizer do
  it "categorizes shops in postal code LS1 correctly" do
    shop_1 = create(:shop, post_code: "LS1 XXX", chairs: 9)
    shop_2 = create(:shop, post_code: "LS1 XXX", chairs: 10)
    shop_3 = create(:shop, post_code: "LS1 XXX", chairs: 100)

    [shop_1, shop_2, shop_3].each do |shop|
      Categorizer.new(shop).assign_category!
    end

    expect(shop_1.category).to eq("ls1 small")
    expect(shop_2.category).to eq("ls1 medium")
    expect(shop_3.category).to eq("ls1 large")
  end

  it "categorizes shops in postal code LS2 correctly" do
    create_10_LS2_shops

    list = Shop.all.to_a
    list.each do |shop|
      Categorizer.new(shop).assign_category!
    end

    small_shops.each { |shop| expect(shop.category).to eq("ls2 small") }
    large_shops.each { |shop| expect(shop.category).to eq("ls2 large") }
  end

  it "categorizes shops that are in neither LS2 or LS1 correctly" do
    shop = create(:shop, post_code: "LS10 XXX")
    Categorizer.new(shop).assign_category!
    expect(shop.category).to eq("other")
  end
end
