class PaypalController < ApplicationController
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  def new
    PayPal::SDK::REST.set_config(
      :mode => "sandbox", # "sandbox" or "live"
      :client_id => "AacFdCumn5IKViaNNqL1T9bCVDMogtn_M2zDzjJkUrsOalo-VX1CkH-Myq9B_sfhxeJtcz4Ues4vb2OF",
      :client_secret => "ENg5V5uXOwMOuSPUsonS7U7lxAW3qEt__RDPrP34gSO6dlMjsZfbIIKQH8jbOj-jvRInIVr7oFystz6a")

    # Build Payment object
    @payment_record = PaymentRecord.where(user_id: current_user.id).last
    items = []
    items << {
            :name => "April Rent",
            :sku => @payment_record.ref_id,
            :price => sprintf("%.2f", @payment_record.amount),
            :quantity => 1,
            :currency => "PHP"
          }

    @payment = {
          :intent => "sale",
          :payer => {:payment_method => "paypal"},
          :transactions =>
            [{
              :amount => {
                :total => sprintf("%.2f", @payment_record.amount),
                :currency => "PHP" },
                :item_list => {
                  :items => items,
                },
                :description => "April Rent Payment"
            }],
          :redirect_urls => {
            :return_url => 'http://localhost:3000',
            :cancel_url => 'http://localhost:3000'
          }
        }

    # Create Payment and return the status(true or false)
    @payment = Payment.new(@payment)
    if @payment.create
      @payment.id     # Payment Id
      PaymentRecord.accept_payment current_user.id
      redirect_to approval_link @payment
    else
      @payment.error  # Error Hash
    end

  end

  private
    def approval_link payment_obj
      payment_obj.links[1].href
    end

end
