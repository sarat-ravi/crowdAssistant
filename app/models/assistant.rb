class Assistant < ActiveRecord::Base
  has_many :tasks
  has_many :mobworkers
end
