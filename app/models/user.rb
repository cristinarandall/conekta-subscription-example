class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :conekta_token, :coupon
  attr_accessor :conekta_token, :coupon
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
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !conekta_token.present?
        raise "Conekta token not present. Can't create account."
      end
      if coupon.blank?
        customer = Conekta::Customer.create(
          :email => email,
          :description => name,
          :card => conekta_token,
          :plan => roles.first.name
        )
      else
        customer = Conekta::Customer.create(
          :email => email,
          :description => name,
          :card => conekta_token,
          :plan => roles.first.name,
          :coupon => coupon
        )
      end
    else
      customer = Conekta::Customer.retrieve(customer_id)
      if conekta_token.present?
        customer.card = conekta_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end
    self.last_4_digits = customer.cards.data.first["last4"]
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
