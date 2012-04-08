# require 
class Assistant < ActiveRecord::Base
  #has_many :tasks
  #has_many :mobworkers
  #@@mob_api_url = "https://work.mobileworks.com/api/v2/job/"
  def handle(task)
    execute_task(task) 
  end
  def execute_task(task)
    response = MobileworksApi.post_task(task)
    @t = task
    @t.mob_task_id = response["location"]
    @t.save!
  end
  def retrieve_task(task)
    response = MobileworksApi.retrieve_task(task)
    @t = task
    @t.status = response["status"]
    @t.answer = response["answer"]
    @t.save!
  end
end
