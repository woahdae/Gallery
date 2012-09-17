class AlbumsController < ApplicationController
  before_filter :load_recent_albums
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index

  before_filter :load_cart

  def show
  end

  def index
    @carousel_photos = CarouselPhoto.scoped
    if @carousel_photos.any?
      render
    elsif @recent_albums.first
      redirect_to @recent_albums.first
    else
      render text: 'what do you want from me!?!'
    end
  end

  private

  def load_recent_albums
    @recent_albums = Album.accessible_by(current_ability).
                        order('id DESC').limit(5)
  end

  def load_cart
    @cart = Cart.find_by_session_id(request.session_options[:id])
  end
end
