if Rails.env.development?
  %w(fan player admin).each do |role|
    admin = (role == 'admin')
    user = User.create(
      username: role,
      email: "#{role}@cfb.de",
      password: 'password',
      admin: admin
    )

    member = Member.create(
      user: user,
      identifier: "{role}1232434353",
      firstname: "First#{role}",
      lastname: "Last#{role}"
    )

    Contact.create(
      member: member,
    )

    Address.create(
      street: 'Hasenheide',
      zipcode: '13346',
      city: 'Hasentown',
      addressable: member
    )

    Player.create(
      nickname: "Nicki #{role}",
      member: member,
    )
  end
end
