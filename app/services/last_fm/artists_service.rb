class LastFm::ArtistsService
  attr_accessor :result
  API_URI = 'http://ws.audioscrobbler.com/2.0'.freeze
  API_KEY = '1ca2cf614eeaa185c2b61753b434b599'.freeze

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