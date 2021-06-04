class RemoveProductFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :histories, :product, null: false, foreign_key: true
  end
end
