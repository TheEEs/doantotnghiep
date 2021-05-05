class AddNeedImportToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :need_import, :bool
  end
end
