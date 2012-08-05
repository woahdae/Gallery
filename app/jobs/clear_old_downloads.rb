class ClearOldDownloads
  def self.call
    Order.where(['created_at < ?', 6.days.ago]).find_each do |order|
      bucket = AWS::S3::Bucket.new(Gallery.settings.s3.zip_bucket)
      bucket.objects[order.uuid].delete # should already be gone
      order.update_attributes(:download_url => "expired")
    end
  end
end
