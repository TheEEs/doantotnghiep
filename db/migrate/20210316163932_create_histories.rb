class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :action, null: false
      t.string :object
      t.references :stock_manager, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
