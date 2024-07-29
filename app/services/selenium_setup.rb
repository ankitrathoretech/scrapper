require 'selenium-webdriver'

module SeleniumSetup
  def setup_selenium
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @driver = Selenium::WebDriver.for :chrome, options: options
  end
end
