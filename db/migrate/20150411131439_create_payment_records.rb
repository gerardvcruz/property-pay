class CreatePaymentRecords < ActiveRecord::Migration
  def change
    create_table :payment_records do |t|
      t.integer :user_id
      t.integer :property_id
      t.decimal :amount
      t.string :status
      t.integer :ref_id

      t.timestamps null: false
    end
  end
end
