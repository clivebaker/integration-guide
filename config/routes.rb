Rails.application.routes.draw do
  resources :post_examples do
    
    post "api_receipt_post"
    get "post_receipt_response"


  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :items

  get 'home/index'
get 'home/post_receipt_identifier'
post 'home/post_receipt'
get 'home/post_user'
post 'home/post_user_2'
post 'home/post_user_response'

get  'home/redeem_loyalty_identifier'
post 'home/redeem_loyalty'
post 'home/redeem_loyalty_2'


get 'home/post_loyalty'
get 'home/get_receipts'
get 'home/get_loyalty_identifier'
post 'home/get_loyalty'
post 'home/get_loyalty_2'
post "home/api_receipt_post"
get "home/post_receipt_finish"

post "home/api_email_post"
get "home/receipt_posted"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
# root 'home#post_receipt_identifier'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
