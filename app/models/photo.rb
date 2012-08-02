require Rails.root + 'lib/watermark_processor'

class Photo < ActiveRecord::Base
  belongs_to :alblum, :inverse_of => :photos
  has_one :user, :through => :alblum

  attr_accessible :image
  has_attached_file :image,
    :processors => [:watermark],
    :styles => {
      :thumb  => "250x250>",
      :medium  => {
        :geometry           => "600x400>",
        :watermark_path     => Rails.root + 'public/watermark.png',
        :watermark_position => 'South',
        :watermark_offset   => {x: 0, y: 50} },
      :large  => {
        :geometry           => "800x600>",
        :watermark_path     => Rails.root + 'public/watermark.png',
        :watermark_position => 'South',
        :watermark_offset   => {x: 0, y: 100} } }

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
