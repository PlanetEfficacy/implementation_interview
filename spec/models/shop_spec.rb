require 'rails_helper'

RSpec.describe Shop, type: :model do
  it "gets unique postal_codes" do
    create(:shop, post_code: "1")
    create(:shop, post_code: "2")
    expect(Shop.postal_codes).to eq(["1","2"])
  end

  it "gets count of places by postal code" do
    create_list(:shop, 2)
    count = Shop.count_by_post(Shop.first.post_code)
    expect(count).to eq(2)
  end

  it "gets count of chairs by postal code" do
    create_list(:shop, 2, chairs: 10)
    count = Shop.chairs_by_post(Shop.first.post_code)
    expect(count).to eq(20)
  end

  it "gets the percent of chairs at this postal code" do
    create(:shop, post_code: "1", chairs: 20)
    create(:shop, post_code: "2", chairs: 80)
    percent = Shop.percent_chairs_at_post(Shop.first.post_code)
    expect(percent).to eq(20)
  end

  it "gets the place with the most chairs at this postal code" do
    shop_1 = create(:shop, chairs: 20, post_code: "1")
    shop_2 = create(:shop, chairs: 80, post_code: "1")
    place = Shop.place_with_max_chairs_at_post("1")
    expect(place).to eq(shop_2)
  end

  it "gets the max chairs at this postal code" do
    shop_1 = create(:shop, chairs: 20, post_code: "1")
    shop_2 = create(:shop, chairs: 80, post_code: "1")
    chairs = Shop.max_chairs_at_post("1")
    expect(chairs).to eq(80)
  end
end
