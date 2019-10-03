require 'rails_helper'

describe 'Artists Routes', type: :routing do
  it 'routes / to the artists controller index action' do
    expect(get: '/').to route_to(controller: 'artists', action: 'index')
  end
end