class Job < ActiveRecord::Base
  belongs_to :user, :assistant
  has_many :tasks
end
