module ApplicationHelper
  BOOTSTRAP_ERRORS = {
    'notice'  => 'alert-success',
    'warning' => '',
    'error'   => 'alert-error',
  }.with_indifferent_access

  def page_title
    front = @album.try(:name)
    front ||= controller_name.match(/cart/) ? 'Your Cart' : nil

    [front, 'KHouck.com'].compact.join(' | ')
  end

  def error_notice
    errors = []
    flash.to_hash.each_pair do |type, message|
      errors << content_tag(:div, message,
                            :class => "alert #{BOOTSTRAP_ERRORS[type]}")
    end
    safe_join(errors)
  end

  def active_album(album, options = {})
    if album.try(:new_record?) && action_name == 'new'
      'active'
    elsif album.try(:id) == options[:current].try(:id)
      'active'
    end
  end

  def user_path(user)
    if user.admin?
      admin_albums_path
    else
      orders_path
    end
  end

  def contact_me
    mail_to 'katie@khouck.com', 'contact me', encode: 'javascript'
  end
end
