Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook",
      "uid"=>"118181138998978630963",
      "user_info"=>{"email"=>"test@xxxx.com", "first_name"=>"John", "last_name"=>"User", "name"=>"John User"}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
