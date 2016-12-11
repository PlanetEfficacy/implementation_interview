class AddCategoryToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :category, :varchar
  end
end
