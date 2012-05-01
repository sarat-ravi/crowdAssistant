require 'spec_helper'
require 'nokogiri'
require 'open-uri'
require 'wolframalpha_api'

describe WolframalphaApi do

  before(:each) do

    builder = Nokogiri::XML::Builder.new do |xml|
    xml.queryresult(:success => "true", :error => "false") {
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

    @raw_xml = builder.to_xml
    @xml = Nokogiri::XML(builder.to_xml)
    @expected_results = ["Result 1","Result 2","Result 3"]

    failure = Nokogiri::XML::Builder.new do |xml|
    xml.queryresult(:success => "false", :error => "true or false, doesn't matter") {
      xml.error {
        xml.msg "ERROR" 
      }
    }
    end

    @raw_xml = failure.to_xml
    @fail_xml = Nokogiri::XML(failure.to_xml)
    @expected_fail_results = nil

  end

  describe "#post_query" do
    it "should post the query and return a hash of results" do

      @query = "This really doesn't matter, as get_response is stubbed"
      WolframalphaApi.stub(:get_response).and_return(@xml)
      WolframalphaApi.stub(:validate_response).and_return(@xml)
      WolframalphaApi.should_receive(:post_query).with(@query).and_return(@expected_results)
      @results = WolframalphaApi.post_query(@query)

      #puts @results.to_s
      
      @results.should == @expected_results

    end
    it "should post the query if xml is true" do
      @query = "This really doesn't matter, as get_response is stubbed"
      WolframalphaApi.stub(:get_response).and_return(@xml)
      WolframalphaApi.should_receive(:post_query).with(@query).and_return(@expected_results)
      @results = WolframalphaApi.post_query(@query)
      @results.should == @expected_results

    end
    it "should return nil if query failed" do
      
      WolframalphaApi.stub(:validate_response).and_return(nil)
      @result = WolframalphaApi.post_query("This doesnt matter because response should fail anyways")
      @result.should == nil

    end
  end

  describe "#get_response" do

    #FIXME: This test is really sketch and wrong, need to fix
    #This code smells
    
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

  describe "#validate_response" do
    
    it "should return xml doc given query is successful" do
      
      @validated_xml = WolframalphaApi.validate_response(@xml)
      #puts "validated xml: "
      #puts @validated_xml
      @validated_xml.should == @xml


    end
    it "should return nil given query is unsuccessful" do
      
      @validated_xml = WolframalphaApi.validate_response(@fail_xml)
      #puts "validated xml: "
      #puts @validated_xml
      @validated_xml.should == nil 

    end

  end

end
