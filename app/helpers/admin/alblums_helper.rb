module Admin::AlblumsHelper
  def active_alblum(alblum, options = {})
    if alblum.try(:new_record?) && action_name == 'new'
      'active'
    elsif alblum.try(:name) == options[:current].try(:name)
      'active'
    end
  end
end
