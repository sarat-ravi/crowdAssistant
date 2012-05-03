require 'json'
class Assistant < ActiveRecord::Base
  #has_many :tasks
  #has_many :mobworkers
  #@@mob_api_url = "https://work.mobileworks.com/api/v2/job/"
  def self.handle(task)
    #execute_task(task)
    results = ask_wolfram(task)
    if results.nil? 
      #this means wolfram failed to give a good result
      execute_task(task)
    else
      #if wolfram succeeded, then what?
      #are we going to save these results anywhere?
      #puts "wolfram can answer this"
      #task.mob_task_id = "wolfram" #-----------------------------------------O
      #task.delete
      #add_wolfram_attrs_for(task)
      task.mob_task_id = "wolfram"
      task.answer = results.to_json
      task.status = "done"
      task.save!
      return "wolfram" 
    end
    
  end

  def self.update_status_for(task)
    if Assistant.wolfram_succeeded_for(task) 
      #redirect to some page that displays wolfram results?
      #puts "lol its a wolfram task. Don't know how to retrieve it yet =D"
    else
      Assistant.retrieve_task(task)
    end
  end

  def self.wolfram_succeeded_for(task)
    return task.mob_task_id == "wolfram" #----------------------------------O
  end
  
  def self.ask_wolfram(task)
    query = task.instructions
    results = WolframalphaApi.post_query(query)
    return results

  end

  def self.execute_task(task)
    response = MobileworksApi.post_task(task)
    raise "response from mobileworks is nil" if response.nil?
    task.mob_task_id = response["Location"]
    raise ("mob_task_id for task " + task.id.to_s + " is nil") if task.mob_task_id.nil?
    task.save!
  end
  def self.retrieve_task(task)
    response = MobileworksApi.retrieve_task(task)
    raise "response from mobileworks is nil. Failed to retrieve task..." if response.nil?
    original = task.status
    newStat = response["status"]
    if task.status != response["status"]
      #UserMailer.task_finished(task).deliver
      # This line is commented because we didn't want to spam emails through GMail
      # Richard had mentioned GMail throttles scripts and we didn't want to risk it.
      # All Funcionality works, we have tested this manually
    end
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
   # DataFile.delete(task.path)
    task.save!
    if original != newStat
      UserMailer.task_finished(task).deliver
    end
  end
  def self.update_all
    tasks = Task.find(:all, :conditions => ["status NOT IN (?)", ["invalid", "complete", "done"]])
#    p "Updating #{tasks.length} tasks..."
    tasks.each do |t|
      Assistant.retrieve_task(t)
    end
  end
end
