Gallery::Application.routes.draw do
  devise_for :users

  namespace :admin do
    root :to => 'alblums#index'
    resources :alblums
  end

  resources :alblums, :only => [:index, :show]
  root :to => 'alblums#index'
end
