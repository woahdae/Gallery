require 'capybara/rails'

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers
  include ActionController::RecordIdentifier

  include Capybara::RSpecMatchers
  include Capybara::DSL

  alias :feature :describe

  self.default_url_options = {:host => Gallery.settings.domain}

  def css_id(object)
    '#' + dom_id(object)
  end
end
