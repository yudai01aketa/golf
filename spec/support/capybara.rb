Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  chrome_options.add_argument('--no-sandbox')         

  driver = Selenium::WebDriver.for :chrome, options: options
end

Capybara.javascript_driver = :chrome_headless

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :chrome, options: {
        browser: :remote,
        url: ENV.fetch("SELENIUM_DRIVER_URL"),
        desired_capabilities: :chrome
      }
    else
      driven_by :selenium_chrome_headless
    end
  end
end
