Conekta.api_key = ENV["CONEKTA_API_KEY"]
CONEKTA_PUBLIC_KEY = ENV["CONEKTA_PUBLIC_KEY"]

#ConektaEvent.setup do
#  subscribe 'customer.subscription.deleted' do |event|
#    user = User.find_by_customer_id(event.data.object.customer)
#    user.expire
#  end
#end
