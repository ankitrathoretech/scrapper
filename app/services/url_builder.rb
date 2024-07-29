require 'uri'

module URLBuilder
  BASE_URL = 'https://www.ycombinator.com/companies'

  def build_url_with_filters(n, filters)
    uri = URI(BASE_URL)
    query_params = []

    query_params << "n=#{n}" if n
    filters.each do |key, values|
      next if values.nil?

      if values.is_a?(Array)
        values.each { |value| query_params << "#{key}=#{value}" }
      elsif values == true
        query_params << "#{key}=true"
      elsif values == false
        query_params << "#{key}=false"
      else
        query_params << "#{key}=#{values}"
      end
    end

    uri.query = query_params.join('&')
    uri.to_s
  end
end
