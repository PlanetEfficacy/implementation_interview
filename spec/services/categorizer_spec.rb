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

  it "re-names large and medium shops" do
    shop_1 = create(  :shop,
                      name: "shop",
                      category: "ls1 large",
                      chairs: 100 )
    shop_2 = create(  :shop,
                      name: "shop",
                      category: "ls1 medium",
                      chairs: 11 )
    shop_3 = create(  :shop,
                      name: "shop",
                      post_code: "LS2 XXX",
                      chairs: 1 )
    shop_4 = create(  :shop,
                      name: "shop",
                      post_code: "LS2 XXX",
                      category: "ls2 large",
                      chairs: 100 )
    shop_5 = create(  :shop,
                      name: "shop",
                      post_code: "LS7 5BN",
                      category: "other",
                      chairs: 80 )

    Categorizer.new(shop_1).rename!
    Categorizer.new(shop_2).rename!
    Categorizer.new(shop_3).rename!
    Categorizer.new(shop_4).rename!
    Categorizer.new(shop_5).rename!

    expect(shop_1.name).to eq("ls1 large shop")
    expect(shop_2.name).to eq("ls1 medium shop")
    expect(shop_3.name).to eq("shop")
    expect(shop_4.name).to eq("ls2 large shop")
    expect(shop_5.name).to eq("shop")
  end
end
