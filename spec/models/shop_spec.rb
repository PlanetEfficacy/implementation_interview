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

  def create_10_LS2_shops
    create(:shop, name: "A", post_code: "LS2 XXX", chairs: 6)
    create(:shop, name: "B", post_code: "LS2 XXX", chairs: 18)
    create(:shop, name: "C", post_code: "LS2 XXX", chairs: 20)
    create(:shop, name: "D", post_code: "LS2 XXX", chairs: 20)
    create(:shop, name: "E", post_code: "LS2 XXX", chairs: 20)
    create(:shop, name: "F", post_code: "LS2 XXX", chairs: 51)
    create(:shop, name: "G", post_code: "LS2 XXX", chairs: 84)
    create(:shop, name: "H", post_code: "LS2 XXX", chairs: 96)
    create(:shop, name: "I", post_code: "LS2 XXX", chairs: 118)
    create(:shop, name: "J", post_code: "LS2 XXX", chairs: 140)
  end

  def create_1_LS1_shop
    create(:shop, post_code: "LS1 XXX", chairs: 10)
  end

  def large_shops
    [ Shop.find_by(name: "F"), Shop.find_by(name: "G"),
      Shop.find_by(name: "H"), Shop.find_by(name: "I"),
      Shop.find_by(name: "J") ]
  end
  def small_shops
    [ Shop.find_by(name: "A"), Shop.find_by(name: "B"),
      Shop.find_by(name: "C"), Shop.find_by(name: "D"),
      Shop.find_by(name: "E") ]
  end
end
