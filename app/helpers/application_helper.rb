module ApplicationHelper
  def page_title
    front = @alblum.try(:name)
    front ||= controller_name.match(/cart/) ? 'Your Cart' : nil

    [front, 'KHouck.com'].compact.join(' | ')
  end

  def error_notice
    errors = []
    flash.to_hash.each_pair do |type, message|
      errors << content_tag(:div, message, :class => type)
    end
    safe_join(errors)
  end

  def active_alblum(alblum, options = {})
    if alblum.try(:new_record?) && action_name == 'new'
      'active'
    elsif alblum.try(:id) == options[:current].try(:id)
      'active'
    end
  end

  def user_path(user)
    if user.admin?
      admin_alblums_path
    else
      orders_path
    end
  end
end
