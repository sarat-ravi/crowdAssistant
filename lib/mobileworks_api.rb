# the mobile works api should go here. 
require 'json'

class MobileworksApi
  #TODO: DRY out code by giving get_response() more responsibilities

  def self.post_task(task)
    p task

    filtered_hash={}

    filtered_hash["instructions"] = task.instructions
    filtered_hash["fields"] = task.fields
    filtered_hash["resource"] = task.resource
    filtered_hash["resourcetype"] = task.resourcetype
    filtered_hash["priority"] = task.priority
    filtered_hash["workflow"] = task.workflow
    filtered_hash["redundancy"] = task.redundancy

    task_hash=filtered_hash
    
    
    #converts ALL task_hash to JSON. instructions and fields are mandatory, and therefore not part of a hash
    #task_hash = {:instructions=>instructions, :fields=>fields}
    #task_hash = task_hash.merge(options)    
    raise( ArgumentError, "task_hash doesn't contain mandatory arguments") unless task_hash.has_key?("instructions") and task_hash.has_key?("fields")
    task_hash_json = task_hash.to_json
    
    # curl to mobileworks with the task_hash_json
    begin
      query = "--data '" + task_hash_json +
        "' https://sandbox.mobileworks.com/api/v2/task/ -u CrowdAssistant:CrowdAss"
      query = query.gsub("\\","")
      query = query.gsub("\"[","[")
      query = query.gsub("]\"","]")
      response = get_response(query)
      hash_response = JSON.parse(response)
      hash_response["Location"] = hash_response["Location"].gsub("http://","https://")
      p hash_response
    rescue
      #raise(MobileworksPostError, "Mobileworks Request failed")
    end
# 
#     #parse the response, extract location of task, return
#     @task_uri = hash_response["Location"]
# 
#     #post_task returns http, but retrieve_task requires https. TODO: clean up this smelly LOC
#     @task_uri = @task_uri.gsub("http:","https:")
# 
#     return @task_uri
      return hash_response

  end

  def self.retrieve_task(task)
    #begin
      #response = get_response("curl " + task.mob_task_id + " -u CrowdAssistant:CrowdAss")
      response = get_response(task.mob_task_id + " -u CrowdAssistant:CrowdAss")
      p response
      hash_response = JSON.parse(response)
    #rescue
      #raise(MobileworksGetError, "Mobileworks get failed, probably due to incorrect task_uri")
    #end

    return hash_response    

  end

  def self.get_response(request)

    response = %x(curl -s #{request})
    return response
  end

  def self.user_profile
    response = get_response("https://work.mobileworks.com/api/v1/userprofile/ -u CrowdAssistant:CrowdAss")
    hash_response = JSON.parse(response)
    return hash_response
    #balance = hash_response["objects"][0]["balance"]
  end

end

#SAMPLE USE CASE
#-----------------------------------------------------------------------------------
# task_uri = MobileworksApi.post_task({:instructions=>"How to write rpsec tests for files in lib dir", :fields=>[{:name=>"t"}], :resource=>"http://www.mobileworks.com/developers/images/samplecard.jpg"})
#
# task_status = MobileworksApi.retrieve_task(task_uri)
# puts task_status

