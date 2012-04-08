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
    task.mob_task_id = response["location"]
    task.save!
    p task
  end
  def retrieve_task(task)
    response = MobileworksApi.retrieve_task(task)
    task.status = response["status"]
    task.answer = response["answer"]
    task.save!
    p task
  end
  def self.update_all()
    tasks = Task.where("status = 'processing' OR status = 'new'")
    tasks.each do |task|
      retrieve_task(task)
    end
  end
end
