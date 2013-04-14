Gallery::Application.routes.draw do
  get 'paypal_notifications/pdt'

  devise_for :users

  root :to => 'categories#index'

  resources :categories, :only => [:index, :show]

  resource :cart, :controller => 'Cart', :only => [:show, :update] do
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
    root :to => 'categories#index'
    resources :categories do
      collection do
        delete :delete_photo
      end
    end

    resources :orders, :only => :index
  end
end
