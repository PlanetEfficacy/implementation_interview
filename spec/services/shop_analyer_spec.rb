require 'rails_helper'

RSpec.describe ShopAnalyzer, type: :model do
  it "gets count of places by postal code" do
    create_list(:shop, 2)
    count = ShopAnalyzer.new(Shop.first.post_code).shop_count

    expect(count).to eq(2)
  end

  it "gets count of chairs by postal code" do
    create_list(:shop, 2, chairs: 10)
    count = ShopAnalyzer.new(Shop.first.post_code).total_chairs

    expect(count).to eq(20)
  end

  it "gets the percent of chairs at this postal code" do
    create(:shop, post_code: "1", chairs: 20)
    create(:shop, post_code: "2", chairs: 80)
    percent = ShopAnalyzer.new(Shop.first.post_code).percent_chairs

    expect(percent).to eq(20)
  end

  it "gets the place with the most chairs at this postal code" do
    shop_1 = create(:shop, chairs: 20, post_code: "1")
    shop_2 = create(:shop, chairs: 80, post_code: "1")
    place = ShopAnalyzer.new("1").place_with_max_chairs

    expect(place).to eq(shop_2)
  end

  it "gets the max chairs at this postal code" do
    shop_1 = create(:shop, chairs: 20, post_code: "1")
    shop_2 = create(:shop, chairs: 80, post_code: "1")
    chairs = ShopAnalyzer.new("1").max_chairs

    expect(chairs).to eq(80)
  end
end
