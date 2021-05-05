class DropStockManagers < ActiveRecord::Migration[6.0]
  def change
    drop_table :stock_managers
  end
end
