require 'ostruct'
class Admin::AlblumsController < AdminController
  load_and_authorize_resource
  before_filter :redirect_to_new_if_no_alblums, :only => :index
  before_filter :load_alblums_unless_present

  def index
    redirect_to [:admin, @alblums.first]
  end

  def show
  end

  def create
    if @alblum.save
      render :new
    else
      redirect_to :index
    end
  end

  private

  def load_alblums_unless_present
    @alblums ||= Alblum.accessible_by(current_ability)
  end

  def redirect_to_new_if_no_alblums
    redirect_to :action => :new if @alblums.empty?
  end
end
