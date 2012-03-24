Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'OsApcB2lpW9CmqXjDaFqw', 'ivi3McKXwMHsN6mXiTCZQtbYUruXuEYbOu2oMqWZjM'
  provider :facebook, '325736630808754', '8119d3396ebd3dfbf501ee6afdde4621'
  provider :google, '464129304782.apps.googleusercontent.com', 'sKlYXAwBVJZKd59YI8vp_4Y9'
end