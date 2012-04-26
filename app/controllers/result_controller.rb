class ResultController < ApplicationController
  def index
    @query = session[:wolfram_query]
    raise "wolfram query is null" if @query.nil?

    @results = WolframalphaApi.post_query(@query)
  end

end
