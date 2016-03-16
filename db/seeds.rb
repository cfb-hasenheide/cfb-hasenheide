%w(fan player admin).each do |role|
  User.create(username: role, email: "#{role}@cfb.de", password: 'password')
end
