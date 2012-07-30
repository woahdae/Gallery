class Photo < ActiveRecord::Base
  belongs_to :alblum, :inverse_of => :photos
  has_one :user, :through => :alblum

  attr_accessible :image
  has_attached_file :image, :styles => {
    :thumb  => "100x100",
    :medium => "200x200",
    :large  => "600x400" }

  validates :image, :attachment_presence => true

  def as_jq_upload
    { "name"          => image_file_name,
      "size"          => image.size,
      "url"           => image.url,
      "thumbnail_url" => image.url(:thumb),
      "delete_url"    => "/admin/alblums/delete_photo?photo_id=#{id}",
      "delete_type"   => "DELETE" }
  end
end
