class CarouselPhoto < ActiveRecord::Base
  attr_accessible :position
  belongs_to :photo

  acts_as_list
end
