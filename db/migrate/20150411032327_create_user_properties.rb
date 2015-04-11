class CreateUserProperties < ActiveRecord::Migration
  def change
    create_table :user_properties do |t|
      t.integer :user_id
      t.integer :property_id
      t.integer :type

      t.timestamps null: false
    end
  end
end
