class Alblum < ActiveRecord::Base
  attr_accessible :name

  def to_param
    [id, *name.underscore.split].join('-')
  end
end
