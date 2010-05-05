require 'active_merchant'

module Testopia
  module ActiveMerchant
    def credit_card_hash(options = {})
      {
        :number => '1',
        :first_name => 'John',
        :last_name => 'Doe',
        :month => '8',
        :year  => "#{Time.now.year + 1}",
        :verification_value => '123',
        :type => 'visa'
      }.update(options)
    end

    def credit_card(options = {})
      ::ActiveMerchant::Billing::CreditCard.new( credit_card_hash(options) )
    end

    def address(options = {})
      {
        :name => "John Doe",
        :address1 => "2500 Oak Mills Road",
        :address2 => "Suite 1000",
        :city => "Beverly Hills",
        :state => "CA",
        :country => "US",
        :zip => '90210'
      }.update(options)
    end
  end
end
