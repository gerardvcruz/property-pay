class PaymentRecord < ActiveRecord::Base

  def self.accept_payment user_id

    conn = Faraday.new(:url => 'https://post.chikka.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    @payment_record = PaymentRecord.where("user_id = ? AND status != ?",
                                          User.first.id, "paid").last

    if @payment_record.nil?
      @message = {:message => "payment record not found", :success => false}
    else
      @payment_record.status = "paid"
      @payment_record.balance = 0
      if @payment_record.save
        response =
          conn.post do |req|
            req.url '/smsapi/request'
            req.body = {
              :message_type => "SEND",
              :mobile_number => 639166200691,
              :shortcode => 29290776729,
              :message_id => @payment_record.ref_id,
              :message => "Your payment for this months rent has been received (powered by PropertyPay)",
              :client_id => "cf06875b905f7483fe596a2f0c125e960902403e52bfc1ad80321b6de10b9dfc",
              :secret_key => "c1a23593e54123d5e374adad26c9ec31e6edd3d0b90a3f657b647f9ce5b0d6fd"
             }
          end
        p response
        @message = {:message => "payment record payment success", :success => true}
      else
        @message = {:message => "payment record accept payment failed", :success => false}
      end
    end

  end

  def self.bill_renter user_id
    conn = Faraday.new(:url => 'https://post.chikka.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    if User.find(user_id).nil?
      @message = {:message => "user not found", :success => false}
    else
      @user = User.find(user_id)
      if PaymentRecord.last.created_at < Date.today - Time.new.day
        @property = Property.find(UserProperty.find_by_user_id(user_id).property_id)
        @payment_record = PaymentRecord.new
        @payment_record.status = "pending"
        @payment_record.amount = @property.rent_price + @property.dues
        @payment_record.balance = @property.rent_price + @property.dues
        @payment_record.ref_id = Array.new(6){[*"0".."9"].sample}.join
        @payment_record.user_id = user_id
        @payment_record.property_id = @property.id

        if @payment_record.save!
          response =
            conn.post do |req|
              req.url '/smsapi/request'
              req.body = {
                :message_type => "SEND",
                :mobile_number => 639166200691,
                :shortcode => 29290776729,
                :message_id => @payment_record.ref_id,
                :message => "This months rent is due (powered by PropertyPay)",
                :client_id => "cf06875b905f7483fe596a2f0c125e960902403e52bfc1ad80321b6de10b9dfc",
                :secret_key => "c1a23593e54123d5e374adad26c9ec31e6edd3d0b90a3f657b647f9ce5b0d6fd"
               }
            end
          p response
          @message = {:message => "succesfully billed resident", :success => true}
        else
          @message = {:message => "error saving", :success => false}
        end
      else
        @message = {:message => "already billed resident for this month", :success => false}
      end
    end
  end
end
