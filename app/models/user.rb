class User < ActiveRecord::Base
  has_many :jobs, :transactions
  has_one :profile
end
