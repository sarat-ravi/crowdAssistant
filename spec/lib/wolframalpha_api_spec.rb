require 'spec_helper'
require 'nokogiri'
require 'open-uri'
require 'wolframalpha_api'

describe WolframalphaApi do

  before(:each) do

    builder = Nokogiri::XML::Builder.new do |xml|
    xml.queryresult {
      xml.pod {
        xml.markup "Result 1" 
      }
      xml.pod {
        xml.markup "Result 2" 
      }
      xml.pod {
        xml.markup "Result 3" 
      }
    }
    end

    @xml = builder.to_xml
    @expected_results = ["Result 1","Result 2","Result 3"]

  end

  describe "#post_query" do
    it "should post the query and return a hash of results" do

      WolframalphaApi.stub(:get_response).and_return(@xml)
      WolframalphaApi.should_receive(:post_query).with(@query).and_return(@expected_results)
      @results = WolframalphaApi.post_query(@query)

      #puts @results.to_s
      
      @results.should == @expected_results

    end
  end

  describe "#get_response" do
    it "should send query to wolfram api and return xml document" do

      @query = "pi"
      @appid = "95PVXL-VJH3UW9ATT"
      @api_url = "http://api.wolframalpha.com/v2/query?input=#{@query}&format=html&appid=#{@appid}"

      @expected_xml = Nokogiri::XML(open(@api_url)) do |config|
        config.strict
      end

      WolframalphaApi.stub(:get_api_url).and_return(@api_url)
      WolframalphaApi.should_receive(:get_response).with(@query).and_return(@expected_xml)
      @result = WolframalphaApi.get_response(@query)

      #puts @result.to_s
      
      @result.should == @expected_xml

    end
  end
end
