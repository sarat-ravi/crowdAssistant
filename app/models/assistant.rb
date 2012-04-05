# require 
class Assistant < ActiveRecord::Base
  has_many :tasks
  has_many :mobworkers
  @@mob_api_url = "https://work.mobileworks.com/api/v2/job/"
  def handle(task)
    execute_task(task) 
  end
  def execute_task(task_params={})
    MobileworksApi.post_task(task_params)
  end

  def retrieve_task(task)
    MobileworksApi.retrieve_task(@@mob_api_url + task.mob_task_id)
  end
end
