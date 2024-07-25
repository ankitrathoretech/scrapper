class ScraperService
  BASE_URL = 'https://www.ycombinator.com/companies'
  
  def initialize(n, filters)
    @n = n
    @filters = filters
    @companies = []
  end

  def scrape
    scrape_first_page
    puts "Companies after first page scrape: #{@companies.inspect}" # Debugging statement
    scrape_additional_pages if @companies.size < @n
    puts "Companies after additional pages scrape: #{@companies.inspect}" # Debugging statement
    save_to_csv
  end

  private

  def scrape_first_page
    byebug
    page = HTTParty.get(BASE_URL)
    doc = Nokogiri::HTML(page.body)
    doc.css('.company').first(@n).each do |company|
      company_data = {
        name: company.css('.company-name').text.strip,
        location: company.css('.company-location').text.strip,
        short_description: company.css('.company-description').text.strip,
        yc_batch: company.css('.yc-batch').text.strip
      }
      @companies << company_data
    end
  end

  def scrape_additional_pages
    @companies.each do |company|
      company_url = company[:url]
      page = HTTParty.get(company_url)
      doc = Nokogiri::HTML(page.body)

      company[:website] = doc.css('.company-website').text.strip
      company[:founders] = doc.css('.founder-name').map(&:text).map(&:strip)
      company[:founders_linkedin] = doc.css('.founder-linkedin').map { |link| link['href'] }
    end
  end

  def save_to_csv
    file_path = Rails.root.join('tmp', 'companies_data.csv')
    CSV.open(file_path, "wb") do |csv|
      csv << ["Name", "Location", "Short Description", "YC Batch", "Website", "Founders", "Founders LinkedIn"]
      @companies.each do |company|
        csv << [
          company[:name],
          company[:location],
          company[:short_description],
          company[:yc_batch],
          company[:website],
          company[:founders].join(", "),
          company[:founders_linkedin].join(", ")
        ]
      end
    end
    puts "CSV saved to #{file_path}" # Debugging statement
    file_path
  end
end
