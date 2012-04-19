class User < ActiveRecord::Base
  has_many :tasks
  has_many :transactions
  has_one :profile
  has_many :payments
  
  def self.create_with_omniauth(auth)
   create! do |user|
     user.provider = auth["provider"]
     user.uid = auth["uid"]
     user.name = auth["info"]["name"]
     user.email = auth["info"]["email"]
     #user.ipaddr = request.remote_ip
   end
  end
end
