class Order < ActiveRecord::Base

  # Callbacks
  before_validation :shipping_address_same_as_billing

  # Validations
  validates_presence_of :billing_address, :billing_first_name, :billing_last_name,
                        :billing_city, :billing_state, :billing_zip

  validates :billing_first_name, length: { maximum: 80, minimum: 2 }
  validates :billing_last_name, length: { maximum: 80, minimum: 2 }
  validates :billing_address, length: { maximum: 80 }
  validates :billing_address2, length: { maximum: 80 }
  validates :billing_city, length: { maximum: 80 }
  validates :billing_state, length: { maximum: 50, minimum: 2, message: 'Please enter a valid state.' }
  validates :billing_phone, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :billing_email, format: { with: VALID_EMAIL_REGEX }

  validates :shipping_first_name, length: { maximum: 80, minimum: 2 }
  validates :shipping_last_name, length: { maximum: 80, minimum: 2 }
  validates :shipping_address, length: { maximum: 80 }
  validates :shipping_address2, length: { maximum: 80 }
  validates :shipping_city, length: { maximum: 80 }
  validates :shipping_state, length: { maximum: 50, minimum: 2 }
  validates :shipping_phone, length: { maximum: 25 }

  # Relations
  has_many :ordered_items

  # Methods

  # total order price
  def total_price
    ordered_items.to_a.sum { |item| item.total_price }
  end

  def tax_amount
    total_price * 0.045
  end

  def taxed_total
    total_price * 1.045
  end

  def add_ordered_items_from_cart(cart)
    cart.ordered_items.each do |item|
      item.cart_id = nil
      ordered_items << item
    end
  end

  def add_shipping_and_tax(method)
    case method
    when "ground"
      self.total = (taxed_total).round(2)
    when "two-day"
      self.total = taxed_total + (15.75).round(2)
    when "overnight"
      self.total = taxed_total + (25).round(2)
    end
  end

  def taxed_plus_shipping_total
    self.total
  end

  def process_credit_card(args, total)
    gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login  => ENV["AUTHORIZE_LOGIN"],
      :password => ENV["AUTHORIZE_PASSWORD"]
    )

    charge_amount = (total.to_f * 100).to_i

    card_type = CardChecker.new(args[:card_info][:card_number]).type

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :number => args[:card_info][:card_number],
      :month => args[:card_info][:card_expiration_month],
      :year => args[:card_info][:card_expiration_year],
      :verification_value => args[:card_info][:cvv],
      :first_name => args[:card_info][:card_first_name],
      :last_name => args[:card_info][:card_last_name],
      :type => card_type
    )

    if credit_card.valid?

      billing_address = { name: "#{args[:billing_first_name]} #{args[:billing_last_name]}",
                          address1: args[:billing_address_line_1],
                          city: args[:billing_city], state: args[:billing_state],
                          country: 'US',zip: args[:billing_zip],
                          phone: args[:billing_phone] }

      options = { address: {}, billing_address: billing_address }

      response = gateway.purchase(charge_amount, credit_card, options)
      
      if !response.success?
        errors.add(:error, "We couldn't process your credit card")
        return false
      end

    else
      errors.add(:error, "Your credit card seems to be invalid")
      return false
    end
    
    self.update(order_status: 'processed')
  end

  private

    def shipping_address_same_as_billing
      if self.shipping_address.empty?
        self.shipping_address = self.billing_address
        self.shipping_address2 = self.billing_address2 if !self.billing_address2.empty?
        self.shipping_first_name = self.billing_first_name
        self.shipping_last_name = self.billing_last_name
        self.shipping_city = self.billing_city
        self.shipping_state = self.billing_state
        self.shipping_zip = self.billing_zip
        self.shipping_email = self.billing_email
        self.shipping_phone = self.billing_phone
      end
    end
end
