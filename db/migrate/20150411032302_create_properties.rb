class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :type
      t.json :coordinates
      t.text :address
      t.text :description

      t.timestamps null: false
    end
  end
end
