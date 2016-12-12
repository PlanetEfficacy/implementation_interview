class CategoriesDashboardController < ApplicationController
  def index
    @categories = Shop.unique_categories
  end
end
