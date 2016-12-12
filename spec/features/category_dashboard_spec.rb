require 'rails_helper'

RSpec.describe "It has a category dashboard view" do
  scenario "that includes category, total_places, and total_chairs" do
    shop_1 = create(:shop, chairs: 25, category: "ls1 medium")
    shop_2 = create(:shop, chairs: 50, category: "ls1 medium")
    shop_3 = create(:shop, chairs: 25, category: "ls1 small")

    visit categories_dashboard_path
    within "#0" do
      expect(page).to have_content("Category")
      expect(page).to have_content("ls1 medium")
      expect(page).to have_content("Total Places")
      expect(page).to have_content(2)
      expect(page).to have_content("Total Chairs")
      expect(page).to have_content(75)
    end
  end
end
