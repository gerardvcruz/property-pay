class RemoveTypeFromUserProperties < ActiveRecord::Migration
  def change
    remove_column :user_properties, :type
  end
end
