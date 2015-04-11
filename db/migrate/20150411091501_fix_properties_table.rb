class FixPropertiesTable < ActiveRecord::Migration
  def change
    drop_table :properties
    create_table :properties do |t|
      t.string "name"
      t.string "property_type"
      t.json "coordinates"
      t.text "address"
      t.text "description"
    end
  end
end
