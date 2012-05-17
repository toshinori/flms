Flms::Application.routes.draw do
  resources :members

  resources :teams

  resources :game_members, only: [:new, :create, :destroy]
  resources :game_fouls, only: [:new, :create, :destroy]

  resources :games do
    member do
      scope 'result' do
        scope 'players' do
          get '' => "game_members#show"
          get 'edit' => "game_members#edit"
          put '' => "game_members#update"
        end

        scope 'fouls' do
          get '' => "game_fouls#show"
          get 'edit' => "game_fouls#edit"
          put '' => "game_fouls#update"
        end

        scope 'goals' do
          get '' => "game_goals#show"
          get 'edit' => "game_goals#edit"
          put '' => "game_goals#update"
        end

        scope 'changes' do
          get '' => "game_player_changes#show"
          get 'edit' => "game_player_changes#edit"
          put '' => "game_player_changes#update"
        end

        get 'edit'  => "games#edit_result"
        get ''  => "games#show_result"
        put ''  => "games#update_result"
      end
    end
  end


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
