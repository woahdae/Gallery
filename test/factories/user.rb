Factory.define(:user) do |u|
  u.email                 'user%d@example.com'
  u.password              'password'
  u.password_confirmation 'password'
end

Factory.define(:admin, parent: :user) do |u|
  u.email 'admin%d@example.com'
  u.admin true
end
