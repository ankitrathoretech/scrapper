require 'nokogiri'

module PageScraper
  def scrape_first_page(n)
    doc = Nokogiri::HTML(@driver.page_source)
    companies_on_page = doc.css('a._company_86jzd_338')
    @companies = []

    loop do
      companies_on_page.each do |company|
        next if @companies.size >= n

        company_data = extract_company_data(company)
        @companies << company_data
      end

      break if @companies.size >= n

      scroll_down_and_wait
      doc = Nokogiri::HTML(@driver.page_source)
      companies_on_page = doc.css('a._company_86jzd_338')
    end
  end

  def scrape_additional_pages
    @companies.each do |company|
      @driver.get(company[:url])
      doc = Nokogiri::HTML(@driver.page_source)
      company[:website] = company[:url]
      company[:founders] = doc.css('.leading-snug .font-bold').map(&:text).map(&:strip)
      company[:founders_linkedin] = doc.css('.leading-snug a[href*="linkedin.com"]').map { |link| link['href'] }
    end
  end

  private

  def extract_company_data(company)
    company_url_path = company.attr('href').sub(/^\/+/, '')
    full_company_url = URI.join(URLBuilder::BASE_URL, company_url_path).to_s
    yc_batch = company.at_css('a._tagLink_86jzd_1023 span.pill')&.text&.strip&.match(/[A-Z]\d{2}/)&.to_s

    {
      name: company.css('span._coName_86jzd_453').text.strip,
      location: company.css('span._coLocation_86jzd_469').text.strip,
      short_description: company.css('span._coDescription_86jzd_478').text.strip,
      yc_batch: yc_batch,
      url: full_company_url
    }
  end

  def scroll_down_and_wait
    @driver.execute_script('window.scrollTo(0, document.body.scrollHeight);')
    sleep(3) # Consider replacing with an explicit wait for better reliability
  end
end



