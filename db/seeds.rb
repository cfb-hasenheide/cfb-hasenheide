if Rails.env.development?
  %w(fan player admin).each do |role|
    admin = (role == 'admin')
    user = User.create(
      username: role,
      email: "#{role}@cfb.de",
      password: 'password',
      admin: admin
    )

    Contact.create(
      user: user,
    )

    Address.create(
      street: 'Hasenheide',
      zipcode: '13346',
      city: 'Hasentown',
      addressable: user
    )

    Player.create(
      nickname: "Nicki #{role}",
      user: user,
    )

    Member.create(
      user: user,
      identifier: "{role}1232434353",
      firstname: "First#{role}",
      lastname: "Last#{role}"
    )
  end
end
