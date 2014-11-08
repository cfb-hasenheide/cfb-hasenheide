%w(fan player admin).each do |role|
  User.send(role).create(username: role,
                         email:    "#{role}@cfb.de",
                         password: 'password')
end
