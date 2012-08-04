DatabaseCleaner.clean_with(:truncation)

class MiniTest::Spec
  before { DatabaseCleaner.clean }
end
