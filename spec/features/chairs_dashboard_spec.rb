# 
#
# 4) Create a view with the following columns[provide the view SQL]
#     post_code: The Post Code
#     total_places: The number of places in that Post Code
#     total_chairs: The total number of chairs in that Post Code
#     chairs_pct: Out of all the chairs at all the Post Codes, what percentage does this Post Code represent (should sum to 100% in the whole view)
#     place_with_max_chairs: The name of the place with the most chairs in that Post Code
#     max_chairs: The number of chairs at the place_with_max_chairs

require 'rails_helper'

RSpec.describe "It has a chairs dashboard view" do
  scenario "that includes post_code, total_places, total_chairs, chairs_pct, place_with_max_chairs, and max_chairs" do
    shop_1 = create(:shop, chairs: 25, postal_code: "LS1 5BN")
    shop_2 = create(:shop, chairs: 50, postal_code: "LS1 5BN")
    shop_3 = create(:shop, chairs: 25, postal_code: "LS2 3AD")

    visit chairs_dashboard_path
    within ".LS1.5BN" do
      expect(page).to have_content("Postal Code")
      expect(page).to have_content(shop_1.postal_code)
      expect(page).to have_content("Total Places")
      expect(page).to have_content(2)
      expect(page).to have_content("Total Chairs")
      expect(page).to have_content(75)
      expect(page).to have_content("Chairs Percent")
      expect(page).to have_content("75%")
      expect(page).to have_content("Place with Max Chairs")
      expect(page).to have_content(shop_2.name)
      expect(page).to have_content("Max Chairs")
      expect(page).to have_content(50)
    end
  end
end
