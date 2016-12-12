class ChairsDashboardController < ApplicationController
  def index
    @post_codes = ShopAnalyzer.postal_codes
  end
end
