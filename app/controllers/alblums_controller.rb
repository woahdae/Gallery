class AlblumsController < ApplicationController
  before_filter :load_recent_alblums
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index

  before_filter :load_cart

  def show
  end

  def index
    if @recent_alblums.any?
      redirect_to @recent_alblums.first
    else
      render
    end
  end

  private

  def load_recent_alblums
    @recent_alblums = Alblum.accessible_by(current_ability).
                        order('id ASC').limit(5)
  end

  def load_cart
    @cart = Cart.find_by_session_id(request.session_options[:id])
  end
end
