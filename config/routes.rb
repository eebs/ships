Ships::Application.routes.draw do

  namespace :admin do
    resources :reservations
  end

  get "reservations" => "reservations#index"
  get "reservations/new" => "reservations#new", :as => :new_reservation
  get "reservations/:id" => "reservations#show", :as => :reservation
  post "reservations" => "reservations#create"
  delete "reservations/:id" => "reservations#destroy"

  devise_for :characters, :controllers => { :registrations => "characters/registrations" }
  scope "/admin" do
    get "characters" => "characters#index"
    get "characters/:id" => "characters#show", :as => :character
  end

  get "notifications/" => "notifications#index"
  get "notifications/index"
  get "notifications/dismiss"
  get "notifications/dismiss_all"

  get "api/orders"
  get "api/" => "api#orders"

  get "report/month"

  get "report/price"
  get "report/" => "report#price"

  scope "/admin" do
    resources :statuses, :ships
    resources :runs do
      collection do
        post :edit_multiple
        put :update_multiple
      end
    end
    resources :jobs
  end

  post "reservations/:id/comment" => "reservation_comments#create", :as => :reservation_comments

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
