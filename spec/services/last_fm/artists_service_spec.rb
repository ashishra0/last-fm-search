require 'rails_helper'

RSpec.describe LastFm::ArtistsService do
  describe '#execute' do
    let(:api_url) { "http://ws.audioscrobbler.com/2.0?api_key=1ca2cf614eeaa185c2b61753b434b599&artist=Dire%20Straits&format=json&method=artist.getinfo" }

    context 'when api call succeeds', :vcr do
      it 'returns name of the artist from last fm' do
        response = LastFm::ArtistsService.new.execute('Dire Straits', 'getinfo')
        expect(response.class).to eq(LastFm::ArtistsService)
        expect(response.result.dig('artist')['name']).to eq('Dire Straits')
      end

      it 'returns names of similar artists' do
        response = LastFm::ArtistsService.new.execute('Dire Straits', 'getinfo')
        expect(response.result.dig('artist')['similar']['artist'].count).to eq(5)
      end
    end

    context 'when api call fails with invalid params', :vcr do
      it 'returns 4xx' do
        response = LastFm::ArtistsService.new.execute('Dire Straits', nil)
        expect(response.class).to eq(LastFm::ArtistsService)
        expect(response.result.dig('error')).to eq(3)
      end
    end

    context 'when api call fails when having network connectivity issues', :turn_off_vcr do
      it 'returns 5xx' do
        stub_request(:get, api_url).with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }).to_raise(SocketError)
        response = LastFm::ArtistsService.new.execute('Dire Straits', 'getinfo')
        expect(response.class).to eq(LastFm::ArtistsService)
        expect(response.result).to be_falsey
      end
    end

    context 'when api call fails when external service is unreachable', :turn_off_vcr do
      it 'returns 5xx' do
        stub_request(:get, api_url).with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }).to_raise(Errno::ECONNREFUSED)
        response = LastFm::ArtistsService.new.execute('Dire Straits', 'getinfo')
        expect(response.class).to eq(LastFm::ArtistsService)
        expect(response.result).to be_falsey
      end
    end

    context 'when api call fails when external service times out', :turn_off_vcr do
      it 'returns 5xx' do
        stub_request(:get, api_url).with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }).to_timeout
        response = LastFm::ArtistsService.new.execute('Dire Straits', 'getinfo')
        expect(response.class).to eq(LastFm::ArtistsService)
        expect(response.result).to be_falsey
      end
    end

  end
end