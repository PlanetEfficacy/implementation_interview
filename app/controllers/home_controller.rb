class HomeController < ApplicationController
  def index
  end

  def export
    respond_to do |format|
      format.html
      format.csv { send_data Shop.export_small_street_cafes }
    end
  end
end
