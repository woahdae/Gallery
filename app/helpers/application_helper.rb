module ApplicationHelper
  def error_notice
    errors = []
    flash.to_hash.each_pair do |type, message|
      errors << content_tag(:div, message, :class => type)
    end
    safe_join(errors)
  end
end
