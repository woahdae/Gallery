class Category < ActiveRecord::Base
  attr_accessible :name, :photos_attributes, :parent_id

  has_ancestry

  extend FriendlyId
  friendly_id :name, use: [:slugged, :scoped], scope: :ancestry

  belongs_to :user, :inverse_of => :categories
  has_many :photos, :inverse_of => :category,
    :dependent => :destroy

  accepts_nested_attributes_for :photos

  validates :name, :presence => true
  validates_associated :photos

  scope :having_photos,
    joins('LEFT JOIN photos ON photos.category_id = categories.id').
    where('photos.id IS NOT NULL').
    uniq
  scope :without_photos,
    joins('LEFT JOIN photos ON photos.category_id = categories.id').
    where('photos.id IS NULL').
    uniq
  scope :after_date, lambda {|date| where('categories.created_at > ?', date)}

  # This is a bit non-rails-standard due to jquery file upload.
  # This receives a hash whose only key is 'images',
  # and whose value is an array of uploaded images.
  def photos_attributes=(photos_attributes)
    self.photos += photos_attributes['images'].map do |image|
      photo = Photo.new(image: image)
      photo.category_id = self.id
      photo
    end
  end

  def has_photos?
    photos.any?
  end
end
