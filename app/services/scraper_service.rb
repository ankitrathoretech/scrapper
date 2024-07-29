require_relative 'url_builder'
require_relative 'selenium_setup'
require_relative 'page_scraper'
require_relative 'company_data_processor'

class ScraperService
  include URLBuilder
  include SeleniumSetup
  include PageScraper
  include CompanyDataProcessor

  def initialize(n, filters)
    @n = n
    @filters = filters
    setup_selenium
  end

  def scrape
    url_with_filters = build_url_with_filters(@n, @filters)
    puts "Scraping URL: #{url_with_filters}"
    @driver.get(url_with_filters)
    sleep(5)

    scrape_first_page(@n)
    puts "Companies after first page scrape: #{@companies.inspect}"
    scrape_additional_pages
    puts "Companies after additional pages scrape: #{@companies.inspect}"
    save_to_csv(@companies)
  ensure
    @driver.quit
  end
end
