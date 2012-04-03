# the mobile works api should go here. 
require 'json'

class MobileworksApi
  #TODO: DRY out code by giving get_response() more responsibilities

  def self.post_task(instructions, fields, options={})
    
    #converts ALL params to JSON. instructions and fields are mandatory, and therefore not part of a hash
    params = {:instructions=>instructions, :fields=>fields}
    params = params.merge(options)    
    params_json = params.to_json
    
    # curl to mobileworks with the params_json
    query = 'curl --data \'' + params_json + '\' https://work.mobileworks.com/api/v2/task/ -u crowd_ass:cs169'
    response = get_response(query)

    #parse the response, extract location of task, return
    hash_response = JSON.parse(response)
    @task_uri = hash_response["Location"]

    #post_task returns http, but retrieve_task requires https. TODO: clean up this smelly LOC
    @task_uri = @task_uri.gsub("http:","https:")

    return @task_uri

  end

  def self.retrieve_task(task_uri)

    response = get_response("curl " + task_uri + " -u crowd_ass:cs169")

    @hash_response = JSON.parse(response)
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
#m = MobileworksApi.new
#task_uri = m.post_task("How to write rpsec tests for files in lib dir",[{:name=>"t"}], {:resource=>"http://www.mobileworks.com/developers/images/samplecard.jpg"})
#
#task_status = m.retrieve_task(task_uri)
#puts task_status

