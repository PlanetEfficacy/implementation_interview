class ChairsDashboardController < ApplicationController
  def index
    @post_codes = Shop.postal_codes
  end
end
