def sign_in(user)
  visit "/en/users/sign_in"
  fill_in 'Логин', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end
