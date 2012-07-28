class AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!

  private

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
