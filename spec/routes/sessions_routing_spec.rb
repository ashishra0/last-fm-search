require 'rails_helper'

describe 'Session Routes', type: :routing do
  it 'routes /login to the sessions controller new action' do
    expect(get: '/login').to route_to(controller: 'sessions', action: 'new')
  end

  it 'routes /logout to the sessions controller destroy action' do
    expect(get: '/logout').to route_to(controller: 'sessions', action: 'destroy')
  end
end