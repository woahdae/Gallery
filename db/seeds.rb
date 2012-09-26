User.new(email:                 'woody.peterson@gmail.com',
         password:              'password',
         password_confirmation: 'password').tap {|u| u.admin = true}.save!
