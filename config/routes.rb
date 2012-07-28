Gallery::Application.routes.draw do
  resource :alblums, :only => [:index, :show]
  root :to => 'alblums#index'
end
