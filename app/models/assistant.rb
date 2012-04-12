require 'json'
class Assistant < ActiveRecord::Base
  #has_many :tasks
  #has_many :mobworkers
  #@@mob_api_url = "https://work.mobileworks.com/api/v2/job/"
  def self.handle(task)
    p "handled"
    execute_task(task) 
  end
  def self.execute_task(task)
    response = MobileworksApi.post_task(task)
    task.mob_task_id = response["Location"]
    task.save!
  end
  def self.retrieve_task(task)
    response = MobileworksApi.retrieve_task(task)
    task.status = response["status"]
    if response["answer"] == response["answer"].to_s
      task.answer = response["answer"]
    else
      json = response["answer"][0]
      task.answer = ""
      json.each do |k, v|
        task.answer += "#{k}: #{v}.  "
      end
      task.answer = task.answer.strip()
    end
    task.save!
  end
  def self.update_all
    tasks = Task.find(:all, :conditions => ["status NOT IN (?)", ["invalid", "complete", "done"]])
    p "Updating #{tasks.length} tasks..."
    tasks.each do |t|
      Assistant.retrieve_task(t)
    end
  end
end
