User.find_or_initialize_by_email('woody.peterson@gmail.com').tap do |user|
  user.password              = 'password'
  user.password_confirmation = 'password'
  user.admin                 = true
  user.save!
end
