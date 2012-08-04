VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

class MiniTest::Spec
  before do
    if metadata[:vcr]
      VCR.insert_cassette metadata[:vcr]
    end
  end

  after do
    if metadata[:vcr]
      VCR.eject_cassette
    end
  end
end
