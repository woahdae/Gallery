Gallery::Application.routes.draw do
  devise_for :users

  root :to => 'alblums#index'

  resources :alblums, :only => [:index, :show]

  resource :cart, :controller => 'Cart', :only => :show do
    member do
      post :add
      delete :remove
    end
  end

  namespace :admin do
    root :to => 'alblums#index'
    resources :alblums do
      collection do
        delete :delete_photo
      end
    end
  end
end
