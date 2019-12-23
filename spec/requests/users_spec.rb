require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Registrations' do
    before do
      get signup_url
      expect(response).to render_template(:new)
    end

    it 'allows users to sign up with valid username and password' do
      post "/users", params: {user: {username: 'validuser', password: 'V@lidPassw0rd'}}

      expect(response).to redirect_to(login_url)
    end

    it 'should not allow users to sign up with invalid username' do
      post "/users", params: {user: {username: 'valid-user', password: 'V@lidPassw0rd'}}
      post "/users", params: {user: {username: 'abc', password: 'V@lidPassw0rd'}}

      expect(response).to have_rendered(:new)
    end
  end

  describe 'Update' do
    let(:user) { FactoryBot.create(:user) }

    before do
      user.authenticate(user.password)
    end

    it 'allows valid users to change password with a valid password' do
      get edit_user_url(user.id)
      put "/users/#{user.id}", params: {user: {password: 'V@lidPassw0rd'}}

      expect(response).to redirect_to(root_url)
    end

    it 'does not allow users to change password with a invalid password' do
      get edit_user_url(user.id)
      put "/users/#{user.id}", params: {user: {password: ''}}
      put "/users/#{user.id}", params: {user: {password: 'abc'}}
      expect(response).to have_rendered(:edit)
    end

  end
end
