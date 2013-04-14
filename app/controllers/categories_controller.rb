class CategoriesController < ApplicationController
  before_filter :load_recent_categories
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index

  before_filter :load_cart

  def show
  end

  # will be cleared on app restart due to transient nature of
  # in-memory cache; good enough for now
  caches_action :index, layout: false

  def index
    @carousel_photos = CarouselPhoto.scoped
    if @carousel_photos.any?
      render
    elsif @recent_categories.first
      redirect_to @recent_categories.first
    else
      render text: 'what do you want from me!?!'
    end
  end

  private

  def load_recent_categories
    @recent_categories = Category.accessible_by(current_ability).
                        order('id DESC').limit(5)
  end

  def load_cart
    @cart = Cart.find_by_session_id(request.session_options[:id])
  end
end
