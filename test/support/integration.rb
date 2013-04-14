require 'capybara/rails'

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers
  include ActionController::RecordIdentifier

  include Capybara::RSpecMatchers
  include Capybara::DSL

  alias :feature :describe

  self.default_url_options = {:host => Gallery.settings.domain}

  before do
    if running_js?
      self.class.default_url_options =
        {host: Capybara.current_session.server.host,
         port: Capybara.current_session.server.port}
    end
  end

  after do
    Capybara.use_default_driver
    self.default_url_options = {:host => Gallery.settings.domain}
  end

  def css_id(object)
    '#' + dom_id(object)
  end

  def sign_in(user)
    unless URI.parse(Capybara.current_url).path == new_user_session_path
      visit new_user_session_path
    end

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  def running_js?
    Capybara.current_driver == Capybara.javascript_driver
  end
end
