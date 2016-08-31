require 'rails_helper'

describe 'players routing', type: :routing do
  let(:id) { '13' }

  it '/players/:id/edit routes to players controller' do
    expect(get("/players/#{id}/edit"))
      .to route_to(controller: 'players', action: 'edit', id: id)
  end

  it ' /players/:id routes to players controller' do
    expect(put("/players/#{id}"))
      .to route_to(controller: 'players', action: 'update', id: id)
  end
end
