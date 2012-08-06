Gallery::Application.routes.draw do
  get 'paypal_notifications/pdt'

  devise_for :users

  root :to => 'albums#index'

  resources :albums, :only => [:index, :show]

  resource :cart, :controller => 'Cart', :only => :show do
    member do
      post :add
      delete :remove
    end
  end

  resources :orders, :only => [:index, :show] do
    member do
      get :download
    end
  end

  namespace :admin do
    root :to => 'albums#index'
    resources :albums do
      collection do
        delete :delete_photo
      end
    end
  end
end
