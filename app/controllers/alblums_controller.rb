class AlblumsController < ApplicationController
  before_filter :load_recent_alblums
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index

  def show
  end

  def index
  end

  private

  def load_recent_alblums
    @recent_alblums = Alblum.accessible_by(current_ability).
                        order('id ASC').limit(5)
  end

end
