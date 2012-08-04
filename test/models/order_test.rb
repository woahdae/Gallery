require_relative '../minitest_helper'

describe Order do
  let(:image1) { File.new(Rails.root + 'test/photos/bikers1.jpg') }
  let(:image2) { File.new(Rails.root + 'test/photos/bikers2.jpg') }

  let(:photo1) { Photo.new(:image => image1) }
  let(:photo2) { Photo.new(:image => image2) }

  let(:order_uuid) { '12345' }
  subject do
    Factory.create(:order, uuid: order_uuid, line_items: [
      Factory.build(:line_item, photo: photo1, size: 'small'),
      Factory.build(:line_item, photo: photo2, size: 'small') ])
  end

  after do
    # These don't matter when using VCR, but when creating new cassettes
    # we want to clean up our s3 bucket
    photo1.destroy
    photo2.destroy
  end

  it 'creates a zip archive in a tempfile', vcr: 's3_images' do
    z = subject.to_zip

    enum = Zip::ZipFile.foreach(z.path)
    enum.count.must_equal 2

    photos = [photo1, photo2]
    enum.each_with_index do |entry, i|
      entry.name.must_equal [order_uuid, photos[i].image_file_name].join('/')
    end
  end
end
