require 'rails_helper'

RSpec.describe "It has a chairs dashboard view" do
  scenario "that includes post_code, total_places, total_chairs, chairs_pct, place_with_max_chairs, and max_chairs" do
    shop_1 = create(:shop, chairs: 25, post_code: "LS1 5BN")
    shop_2 = create(:shop, chairs: 50, post_code: "LS1 5BN")
    shop_3 = create(:shop, chairs: 25, post_code: "LS2 3AD")

    visit chairs_dashboard_path
    within "#0" do
      expect(page).to have_content("Postal Code")
      expect(page).to have_content(shop_1.post_code)
      expect(page).to have_content("Total Places")
      expect(page).to have_content(2)
      expect(page).to have_content("Total Chairs")
      expect(page).to have_content(75)
      expect(page).to have_content("Chairs Percent")
      expect(page).to have_content("75.00%")
      expect(page).to have_content("Place with Max Chairs")
      expect(page).to have_content(shop_2.name)
      expect(page).to have_content("Max Chairs")
      expect(page).to have_content(50)
    end
  end
end
