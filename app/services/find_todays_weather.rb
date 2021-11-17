class FindTodaysWeather
  class << self
    def find(postcode)
      url = "https://api.weatherapi.com/v1/forecast.json?key=55b7fdf17805493199a143223212409&q=#{postcode}&days=0"
      response = HTTParty.get url
      parsed_response = JSON.parse(response.body)

      raise BadWeatherRequest, parsed_response['error']['message'] if parsed_response['error'].present?

      parsed_response['forecast']['forecastday'][0]['day']['maxtemp_c']
    end
  end
end
