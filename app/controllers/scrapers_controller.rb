class ScrapersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    n = params[:n].to_i
    filters = params[:filters] || {}

    scraper = ScraperService.new(n, filters)
    scraper.scrape

    render json: { message: "Scraping completed and data saved to CSV" }, status: :ok
  end
end
