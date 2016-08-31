require 'rails_helper'

describe 'contact routing', type: :routing do
  let(:id) { '13' }

  it 'routes /contacts/:id to contact controller' do
    expect(get("contacts/#{id}/edit"))
      .to route_to(controller: 'contacts', action: 'edit', id: id)
  end

  it ' routes /contacts/:id to contact controller' do
    expect(put("/contacts/#{id}"))
      .to route_to(controller: 'contacts', action: 'update', id: id)
  end
end
