require Rails.root + 'lib/watermark_processor'

class Photo < ActiveRecord::Base
  belongs_to :album, :inverse_of => :photos
  has_one :user, :through => :album

  attr_accessible :image
  has_attached_file :image,
    :processors => [:watermark],
    :storage    => :s3,
    :s3_permissions => {
      :original        => :private,
      :thumb           => :public_read,
      :medium          => :public_read,
      :large           => :public_read,
      :purchase_small  => :private,
      :purchase_medium => :private,
      :purchase_large  => :private },
    :s3_credentials => {
      :access_key_id     => Gallery.settings.s3.access_key_id,
      :secret_access_key => Gallery.settings.s3.secret_access_key },
    :bucket => Gallery.settings.s3.bucket,
    :styles => {
      :thumb  => "250x250>",
      :medium  => {
        :geometry           => "450x300>",
        :watermark_path     => Rails.root + 'public/watermark.png',
        :watermark_position => 'South',
        :watermark_offset   => {x: 0, y: 100} },
      :large  => {
        :geometry           => "800x600>",
        :watermark_path     => Rails.root + 'public/watermark.png',
        :watermark_position => 'South',
        :watermark_offset   => {x: 0, y: 200} },
      :purchase_small  => '640x480>',
      :purchase_medium => '640x480>',
      :purchase_large  => '640x480>' }

  validates :image, :attachment_presence => true

  def as_jq_upload
    { "name"          => image_file_name,
      "size"          => image.size,
      "url"           => image.url,
      "thumbnail_url" => image.url(:thumb),
      "delete_url"    => "/admin/albums/delete_photo?photo_id=#{id}",
      "delete_type"   => "DELETE" }
  end
end
