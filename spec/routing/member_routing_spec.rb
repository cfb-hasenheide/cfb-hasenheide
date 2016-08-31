require 'rails_helper'

describe 'member routing', type: :routing do
  let(:id) { '13' }

  it 'routes /members/:id to member controller' do
    expect(get("members/#{id}/edit"))
      .to route_to(controller: 'members', action: 'edit', id: id)
  end

  it ' routes /members/:id to member controller' do
    expect(put("/members/#{id}"))
      .to route_to(controller: 'members', action: 'update', id: id)
  end
end
