require 'rails_helper'

RSpec.describe "Landing page" do
  scenario "it includes navigation links" do
    visit root_path
    expect(page).to have_link("Chairs dashboard")
    expect(page).to have_link("Categories dashboard")
  end

  scenario "clicking chairs dashboard link takes visitor to chairs dashboard" do
    visit root_path
    click_link "Chairs dashboard"
    expect(current_path).to eq(chairs_dashboard_path)
  end

  scenario "clicking categories dashboard link takes visitor to categories dashboard" do
    visit root_path
    click_link "Categories dashboard"
    expect(current_path).to eq(categories_dashboard_path)
  end

  scenario "clicking export small shops" do
    visit root_path
    click_link "Export Small Shops"
    expect(current_path).to eq("/export.csv")
  end
end
