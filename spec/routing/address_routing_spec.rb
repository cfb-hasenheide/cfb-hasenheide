require 'rails_helper'

describe 'addresses routing', type: :routing do
  let(:id) { '13' }

  it '/addresses/:id/edit routes to addresses controller' do
    expect(get("/addresses/#{id}/edit"))
      .to route_to(controller: 'addresses', action: 'edit', id: id)
  end

  it ' /addresses/:id routes to addresses controller' do
    expect(put("/addresses/#{id}"))
      .to route_to(controller: 'addresses', action: 'update', id: id)
  end
end
