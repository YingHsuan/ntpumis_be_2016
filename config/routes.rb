Rails.application.routes.draw do
  root :to => 'teachers#index'
  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  resources :teachers, :students, :theses, :posts, :events, :downloads

  post 'thesis/list' => 'theses#list'
  post 'thesis/create' => 'theses#create_api'
  post 'thesis/detail/:thesisId' => 'theses#detail'
  post 'thesis/update/:thesisId' => 'theses#update_api'
  post 'thesis/delete/:thesisId' => 'theses#delete'

  # teacher routes
  post 'teacher/list' => 'teachers#list'
  post 'teacher/create' => 'teachers#create_api'
  post 'teacher/update/:teacherId' => 'teachers#update_api'
  post 'teacher/delete/:teacherId' => 'teachers#delete'

  # post routes
  post 'posts/list' => 'posts#list'
  # event routes
  post 'events/list' => 'events#list'
  
  #download routes
    post 'downloads/list' => 'downloads#list'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
