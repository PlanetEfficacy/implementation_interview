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
    shop_1 = create(:shop, post_code: "LS2 XXX", chairs: 6)
    shop_2 = create(:shop, post_code: "LS2 XXX", chairs: 18)
    shop_3 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_4 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_5 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_6 = create(:shop, post_code: "LS2 XXX", chairs: 51)
    shop_7 = create(:shop, post_code: "LS2 XXX", chairs: 84)
    shop_8 = create(:shop, post_code: "LS2 XXX", chairs: 96)
    shop_9 = create(:shop, post_code: "LS2 XXX", chairs: 118)
    shop_10 = create(:shop, post_code: "LS2 XXX", chairs: 140)

    create(:shop, post_code: "LS1 XXX", chairs: 10)

    expect(Shop.percentile_50).to eq(35.5)
  end

  it "is small or large based on percentile" do
    shop_1 = create(:shop, post_code: "LS2 XXX", chairs: 6)
    shop_2 = create(:shop, post_code: "LS2 XXX", chairs: 18)
    shop_3 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_4 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_5 = create(:shop, post_code: "LS2 XXX", chairs: 20)
    shop_6 = create(:shop, post_code: "LS2 XXX", chairs: 51)
    shop_7 = create(:shop, post_code: "LS2 XXX", chairs: 84)
    shop_8 = create(:shop, post_code: "LS2 XXX", chairs: 96)
    shop_9 = create(:shop, post_code: "LS2 XXX", chairs: 118)
    shop_10 = create(:shop, post_code: "LS2 XXX", chairs: 140)

    create(:shop, post_code: "LS1 XXX", chairs: 10)

    expect(shop_1.small_or_large).to eq("small")
    expect(shop_2.small_or_large).to eq("small")
    expect(shop_3.small_or_large).to eq("small")
    expect(shop_4.small_or_large).to eq("small")
    expect(shop_5.small_or_large).to eq("small")
    expect(shop_6.small_or_large).to eq("large")
    expect(shop_7.small_or_large).to eq("large")
    expect(shop_8.small_or_large).to eq("large")
    expect(shop_9.small_or_large).to eq("large")
    expect(shop_10.small_or_large).to eq("large")
  end
end
