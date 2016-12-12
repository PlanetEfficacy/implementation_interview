require 'rails_helper'

RSpec.describe CategoryAnalyzer do
  it "gets count of places by category" do
    create_list(:shop, 2, category: "A")

    expect(CategoryAnalyzer.new("A").shop_count).to eq(2)
  end

  it "gets count of places by category" do
    create_list(:shop, 2, category: "A", chairs: 20)

    expect(CategoryAnalyzer.new("A").chair_count).to eq(40)
  end
end
