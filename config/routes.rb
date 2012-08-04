Gallery::Application.routes.draw do
  get 'paypal_notifications/pdt'

  devise_for :users

  root :to => 'alblums#index'

  resources :alblums, :only => [:index, :show]

  resource :cart, :controller => 'Cart', :only => :show do
    member do
      post :add
      delete :remove
    end
  end

  resources :orders, :only => [:show]

  namespace :admin do
    root :to => 'alblums#index'
    resources :alblums do
      collection do
        delete :delete_photo
      end
    end
  end
end
