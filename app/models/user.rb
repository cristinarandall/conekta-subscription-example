class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :card, :password_confirmation, :remember_me, :conekta_token, :coupon
  attr_accessor :conekta_token, :coupon, :card
  before_save :update_conekta
  before_destroy :cancel_subscription

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      customer = Conekta::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => role.name)
    end
    true
  rescue Conekta::ConektaError => e
    logger.error "Conekta Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end
  
  def update_conekta

    if customer_id.nil?

      puts "Creating the account------------" 

      card_array = []
      card_array << conekta_token
      if !conekta_token.present?
        raise "Conekta token not present. Can't create account."
      end
        customer = Conekta::Customer.create(
          :email => email,
          :description => name,
          :name => name,
          :cards => card_array,
          :plan => 'silver-plan', #silver plan already created
        )
	puts "-----customer-----"
	puts customer

    else
      customer = Conekta::Customer.retrieve(customer_id)
      if conekta_token.present?
        customer.card = conekta_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    if customer.cards && customer.cards[0]
    self.last_4_digits = customer.cards[0].last4
    end

    self.customer_id = customer.id

    self.conekta_token = nil
  rescue Conekta::ConektaError => e
    logger.error "Conekta Error: " + e.message
    errors.add :base, "#{e.message}."
    self.conekta_token = nil
    false
  end
  
  def cancel_subscription
    unless customer_id.nil?
      customer = Conekta::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Conekta::ConektaError => e
    logger.error "Conekta Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end
  
end
