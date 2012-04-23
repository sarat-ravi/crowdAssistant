require 'nokogiri'

class WolframalphaApi

  def self.post_query(query)
    
    response = self.get_response(query)

    @xml_response = Nokogiri::XML(response) do |config|
      config.strict
    end

    @results = @xml_response.xpath("//markup")
    return @results

  end

  def self.get_response(query)
    #do some curl thing here
    @api_url = self.get_api_url(query) 
    @response = %x(curl -s #{@api_url})
    return @response

  end

  def self.get_api_url(query)

    @appid = "95PVXL-VJH3UW9ATT"
    @api_url = "http://api.wolframalpha.com/v2/query?input=#{query}&format=html&appid=#{@appid}"
    return @api_url

  end

  
end
