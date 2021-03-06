RailsConektaMembershipSaas::Application.routes.draw do
  get "content/gold"
  get "content/silver"
  get "content/platinum"


  authenticated :user do
    root :to => 'home#index'
  end

  match 'webhooks' => 'webhooks#index'
 root :to => "home#index"
    match '' => 'registrations#new'
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  resources :users
end
