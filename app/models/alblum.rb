class Alblum < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  def to_param
    [id, *name.underscore.split].join('-')
  end
end
