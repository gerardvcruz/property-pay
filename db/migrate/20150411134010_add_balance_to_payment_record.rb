class AddBalanceToPaymentRecord < ActiveRecord::Migration
  def change
    add_column :payment_records, :balance, :decimal
  end
end
