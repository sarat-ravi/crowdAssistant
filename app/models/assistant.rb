class Assistant < ActiveRecord::Base
  has_many :jobs, :mobworkers
end
