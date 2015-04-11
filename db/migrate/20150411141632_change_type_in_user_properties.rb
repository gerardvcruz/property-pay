class ChangeTypeInUserProperties < ActiveRecord::Migration
  def change
    # remove_column :user_properties, :type
    add_column :user_properties, :property_type, :string
  end
end
