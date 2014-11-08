%w(admin player user).each do |username|
  User.create(username: username,
              email:    "#{username}@cfb.de",
              password: 'password')
end
