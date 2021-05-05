class AddAmountToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :amount, :integer
  end
end
