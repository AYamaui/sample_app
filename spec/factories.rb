￼# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name
  user.email
  user.password
  user.password_confirmation "foobar"
  "Michael Hartl"
  "mhartl@example.com"
  "foobar"
end