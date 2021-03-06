WwwDesign::Application.routes.draw do

  get "requests/create"

  get "requests/destroy"

  root :to => 'pages#home'
  
  resources :users
  resources :ads do
    resources :categories
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :requests, :only => [:create, :destroy]
  resources :categories
  resources :password_resets

  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/ads/toggle/:id' => 'ads#toggle_available', :as => :toggle
  match '/ads/:id/show_request' => 'ads#show_request', :as => :show_request
  match '/categories/filter_categories/:id', :controller=>'categories', :action => 'filter_categories'
  match '/categories/get_parts/:id', :controller=>'categories', :action => 'get_parts'
  match '/gender/:gender', :to => 'sessions#change_gender'
  
  match '/search/', :to => 'search#index'
  match '/search/category/:id' => 'search#filter_category', :as => :filterc
  match '/search/category/:c_id/:p_id' => 'search#filter_parts', :as => :filterp
  match '/search/filter' => 'search#filter', :as => :filter
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  get "pages/search"
  get "pages/home"
  get "pages/about"
  get "pages/contact"
  
 
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
   

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
