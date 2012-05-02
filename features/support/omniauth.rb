Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook",
      "uid"=>"181138998978630963",
      "info"=>{"email"=>"test@xxxx.com", "name" => "John User", "image" => "www.gravatar.com/image.jpg"}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
