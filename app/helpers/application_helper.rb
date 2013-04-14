module ApplicationHelper
  BOOTSTRAP_ERRORS = {
    'notice'  => 'alert-success',
    'warning' => '',
    'error'   => 'alert-error',
  }.with_indifferent_access

  def page_title
    front = @category.try(:name)
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

  def active_category(category, options = {})
    if category.try(:new_record?) && action_name == 'new'
      'active'
    elsif category.try(:id) == options[:current].try(:id)
      'active'
    elsif options[:include_ancestry] &&
          options[:current].try(:ancestry).to_s.split('/').
            include?(category.id.try(:to_s))
      'active'
    end
  end

  def user_path(user)
    if user.admin?
      admin_categories_path
    else
      orders_path
    end
  end

  def contact_me
    mail_to 'katie@khouck.com', 'contact me', encode: 'javascript'
  end

  def category_path(*args)
    if args.first.is_a?(Category)
      "/#{args.first.ancestors.map(&:slug).join('/')}/#{args.first.slug}"
    elsif args.first.is_a?(Integer)
      category_path(Category.find(args.first), *args[1..-1])
    else
      super
    end
  end
end
