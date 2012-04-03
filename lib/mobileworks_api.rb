# the mobile works api should go here. 
require 'json'

class MobileworksApi
  #TODO: DRY out code by giving get_response() more responsibilities

  def self.post_task(params={})
    
    #converts ALL params to JSON. instructions and fields are mandatory, and therefore not part of a hash
    #params = {:instructions=>instructions, :fields=>fields}
    #params = params.merge(options)    
    raise( ArgumentError, "Params doesn't contain mandatory arguments") unless params.has_key?(:instructions) and params.has_key?(:fields)
    begin
      params_json = params.to_json
    rescue
      raise "Malformed Parameters Hash for post_task"
    end
    
    # curl to mobileworks with the params_json
    begin
      query = 'curl --data \'' + params_json + '\' https://work.mobileworks.com/api/v2/task/ -u crowd_ass:cs169'
      response = get_response(query)
      hash_response = JSON.parse(response)
    rescue
      raise(MobileworksPostError, "Mobileworks Request failed")
    end

    #parse the response, extract location of task, return
    @task_uri = hash_response["Location"]

    #post_task returns http, but retrieve_task requires https. TODO: clean up this smelly LOC
    @task_uri = @task_uri.gsub("http:","https:")

    return @task_uri

  end

  def self.retrieve_task(task_uri)

    begin
      response = get_response("curl " + task_uri + " -u crowd_ass:cs169")
      @hash_response = JSON.parse(response)
    rescue
      raise(MobileworksGetError, "Mobileworks get failed, probably due to incorrect task_uri")
    end

    return @hash_response    

  end

  private
  def self.get_response(request)

    response = %x(#{request})
    return response

  end

end

#SAMPLE USE CASE
#-----------------------------------------------------------------------------------
#task_uri = MobileworksApi.post_task({:instructions=>"How to write rpsec tests for files in lib dir", :fields=>[{:name=>"t"}], :resource=>"http://www.mobileworks.com/developers/images/samplecard.jpg"})
#
#task_status = MobileworksApi.retrieve_task(task_uri)
#puts task_status

