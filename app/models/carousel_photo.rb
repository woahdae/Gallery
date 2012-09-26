class CarouselPhoto < ActiveRecord::Base
  attr_accessible :position, :photo
  belongs_to :photo

  acts_as_list
end
