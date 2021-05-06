class CreateHistoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :history_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :history, null: false, foreign_key: true
      t.integer :amount
      t.integer :number

      t.timestamps
    end
  end
end
