class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if request.referrer
      redirect_to :back, :alert => exception.message
    else
      redirect_to '/', :alert => exception.message
    end
  end
end
