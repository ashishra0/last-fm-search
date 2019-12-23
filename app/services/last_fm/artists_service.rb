class LastFm::ArtistsService
  attr_accessor :result
  API_URI = Rails.application.credentials.last_fm_api_url.freeze
  API_KEY = Rails.application.credentials.last_fm_api_key.freeze

  def execute(artist_name, method_name)
    begin
      url = url_builder(method_name, artist_name)
      response = HTTParty.get(url)
      self.result = JSON.parse(response.body)
    rescue SocketError
      Rails.logger.debug('could not reach external service due to network connectivity issue')
      self.result = false
    rescue Errno::ECONNREFUSED => e
      Rails.logger.debug("500 from external service due to #{e.message}")
      self.result = false
    rescue Timeout::Error => e
      Rails.logger.debug("Request timed out -> #{e.message}")
      self.result = false
    end
    self
  end

  private

  def url_builder(method_name, artist_name)
    url = "#{API_URI}?api_key=#{API_KEY}&format=json"
    url += "&artist=#{artist_name}" if artist_name
    url += "&method=artist.#{method_name}" if method_name
    url
  end
end