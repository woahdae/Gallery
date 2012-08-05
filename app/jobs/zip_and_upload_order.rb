class ZipAndUploadOrder < Struct.new(:order)
  attr_reader :s3_object

  def call
    tempfile = order.to_zip
    bucket = AWS::S3::Bucket.new(Gallery.settings.s3.zip_bucket)
    @s3_object = bucket.objects[order.uuid].write(tempfile.read, acl: :public_read)
    order.update_attributes(:download_url => @s3_object.public_url.to_s)
  end
end
