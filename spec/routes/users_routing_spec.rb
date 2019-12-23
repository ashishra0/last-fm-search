require 'rails_helper'

describe 'User Routes', type: :routing do
  it 'routes /signup to the users controller new action' do
    expect(get: '/signup').to route_to(controller: 'users', action: 'new')
  end

  it 'routes /users/:id/edit to the users controller edit action' do
    expect(get: "/users/1/edit").to route_to(controller: 'users', action: 'edit', id: "1")
  end
end