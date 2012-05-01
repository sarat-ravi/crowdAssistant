require 'nokogiri'

class WolframalphaApi

  def self.post_query(query)
    
    #response = self.get_response(query)


    @xml_response = self.get_response(query)
    @xml_response = self.validate_response(@xml_response)

    return nil if @xml_response.nil?

    @results = @xml_response.xpath("//markup")
    @results = self.remove_tags(@results, "<markup>")
    @results = self.extract_html(@results)
    return @results

  end

  def self.get_response(query)
    #do some curl thing here
    @api_url = self.get_api_url(query) 
    #puts "api_url: "
    #puts @api_url.to_s
    @response = %x(curl -s #{@api_url})

    @xml_response = get_xml_response(@response)
    #puts "xml response: "
    #puts @xml_response.to_xml
    return @xml_response

  end

  def self.validate_response(xml_response)
    #return response if good, nil if unsuccessful query
    @query_success = xml_response.css("queryresult").first["success"] 

    if @query_success == "true"
      return xml_response
    elsif @query_success == "false"
      return nil
    else
      raise "queryresult success attr is neither true or false, which is impossible"
    end

    return nil
    
  end

  def self.get_xml_response(response)

    @xml_response = Nokogiri::XML(response) do |config|
      config.strict
    end

    return @xml_response
  end

  def self.get_api_url(query)

    @appid = "95PVXL-VJH3UW9ATT"
    query.gsub!(/\\|'|"/) { |c| "" }
    query = URI.escape(query)
    @api_url = "'http://api.wolframalpha.com/v2/query?input=#{query}&format=html&appid=#{@appid}'"
    return @api_url

  end

  def self.remove_tags(results, tag)

    tag_len = tag.length
    results = results.map {|result| result.to_s}
    results = results.map {|result| result[tag_len..result.length-tag_len-2]}
    return results

  end
  def self.extract_html(results)
    results = results.map {|result| result.to_s.html_safe}
    results = results.map {|result| result[9..result.length-4]}
    return results

  end

  
end
#Sample use case
#____________________________________________________
#results = WolframalphaApi.post_query("pi")
#puts "first result: "
#puts "---------------------------------"
#puts results[0].to_s
#puts ""
#puts "second result: "
#puts "---------------------------------"
#puts results[1].to_s
