%w(fan player admin).each do |role|
  admin = (role == 'admin')
  User.create(
    username: role,
    email: "#{role}@cfb.de",
    password: 'password',
    admin: admin
  )
end
