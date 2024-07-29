require 'csv'

module CompanyDataProcessor
  def save_to_csv(companies)
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    file_path = Rails.root.join('tmp', "#{timestamp}_companies_data.csv")
    CSV.open(file_path, "wb") do |csv|
      csv << ["Name", "Location", "Short Description", "YC Batch", "Website", "Founders", "Founders LinkedIn"]
      companies.each do |company|
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
    puts "CSV saved to #{file_path}"
    file_path
  end
end
