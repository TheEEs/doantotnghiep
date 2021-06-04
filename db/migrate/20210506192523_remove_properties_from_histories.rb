class RemovePropertiesFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :histories, :price, :integer
    remove_column :histories, :amount, :integer
  end
end
