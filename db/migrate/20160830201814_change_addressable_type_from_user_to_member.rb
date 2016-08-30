class ChangeAddressableTypeFromUserToMember < ActiveRecord::Migration[5.0]
  def up
    Address.where(addressable_type: "User").each do |address|
      member = Member.find_by(user_id: address.addressable_id)
      address.update(addressable: member)
    end
  end

  def down
    Address.where(addressable_type: "Member").each do |address|
      member = Member.find(address.addressable_id)
      address.update(addressable: member.user)
    end
  end
end
