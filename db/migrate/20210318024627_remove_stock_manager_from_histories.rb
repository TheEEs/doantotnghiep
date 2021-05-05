class RemoveStockManagerFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :histories, :stock_manager, null: false, foreign_key: true
  end
end
