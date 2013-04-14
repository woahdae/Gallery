class Category < ActiveRecord::Base
  attr_accessible :name, :photos_attributes

  belongs_to :user, :inverse_of => :albums
  has_many :photos, :inverse_of => :album,
    :dependent => :destroy

  accepts_nested_attributes_for :photos

  validates :name, :presence => true
  validates_associated :photos

  # This is a bit non-rails-standard due to jquery file upload.
  # This receives a hash whose only key is 'images',
  # and whose value is an array of uploaded images.
  def photos_attributes=(photos_attributes)
    self.photos += photos_attributes['images'].map do |image|
      photo = Photo.new(image: image)
      photo.album_id = self.id
      photo
    end
  end

  def to_param
    [id, *name.underscore.split].join('-')
  end
end
