class AddDuesToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :dues, :decimal
  end
end
