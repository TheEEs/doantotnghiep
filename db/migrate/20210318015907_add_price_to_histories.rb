class AddPriceToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :price, :integer
  end
end
