require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  describe 'Search Similar Artists', :vcr do
    let(:api_url) { "http://ws.audioscrobbler.com/2.0?api_key=1ca2cf614eeaa185c2b61753b434b599&artist=Dire%20Straits&format=json&method=artist.getinfo" }
    let(:user) { FactoryBot.create(:user) }

    it 'allows users to search for an artist when logged in and having valid search parameters' do
      get login_url
      post "/sessions", params: {username: user.username, password: user.password}
      expect(response).to redirect_to(root_url)

      get '/', params: {search: {query: 'Dire Straits', method: 'getinfo'}}

      expect(response).to render_template(:index)
      expect(response.body).to include("Signed in as #{user.username}")
      expect(response.body).to include('Dire Straits')
    end

    it 'does not allow users to search if not logged in' do
      get '/', params: {search: {query: 'Dire Straits', method: 'getinfo'}}

      expect(response).to redirect_to(login_path)
    end

    it 'displays error if artists cannot be searched' do
      stub_request(:get, api_url).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }).to_raise(Errno::ECONNREFUSED)

      get login_url
      post "/sessions", params: {username: user.username, password: user.password}
      expect(response).to redirect_to(root_url)

      get '/', params: {search: {query: 'Dire Straits', method: 'getinfo'}}

      expect(response).to render_template(:index)
      expect(response.body).to include('Cannot search at the moment. Please try after some time')
    end
  end
end