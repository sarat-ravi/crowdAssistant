class ResultController < ApplicationController
  def index
    #@query = session[:wolfram_query]

    
    # raise "wolfram query is null" if @query.nil?

    # @results = WolframalphaApi.post_query(@query)
    task_id = session[:wolfram_task_id]
    @task = Task.find_by_id(task_id)
    @results = JSON.parse(@task.answer) 
    if @results.kind_of? String
      debugger
      puts "result is string, which is wrong"
      #@results = @results[1..-2].split(',').collect! {|n| n.to_s}
      
    end
  end

end
