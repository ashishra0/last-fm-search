require 'rails_helper'
RSpec.describe "Sessions", type: :request do

  describe 'Authentication' do
    let(:user) { FactoryBot.create(:user) }
    before do
      get login_url
      expect(response).to render_template(:new)
    end

    it 'allows users to log in with correct username and password' do
      post "/sessions", params: {username: user.username, password: user.password}

      expect(response).to redirect_to(root_url)
    end

    it 'should not allow users to log in with incorrect username' do
      post "/sessions", params: {username: 'notValidUserName', password: user.password}

      expect(response).to render_template(:new)
    end

    it 'should not allow users to log in with incorrect password' do
      post "/sessions", params: {username: user.username, password: 'Invalid-passw0rd'}

      expect(response).to render_template(:new)
    end

    it 'should allow users to log out' do
      get '/logout'
      expect(response).to have_http_status(:redirect)
    end
  end
end