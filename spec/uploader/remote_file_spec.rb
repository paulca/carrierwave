# encoding: utf-8

require 'spec_helper'
require 'cgi'

describe CarrierWave::Uploader::Download::RemoteFile do
  
  describe "#escape" do
    let(:base)       { CarrierWave::Uploader::Download::RemoteFile }
    subject          { base.new('http://google.com/?q=stuff and stuff') }
    
    context "default" do
      it "should escape the URI" do
        subject.instance_variable_get("@uri").to_s.
          should == "http://google.com/?q=stuff%20and%20stuff"
      end
    end
    
    context "over-ridden" do
      before do
        def CarrierWave.escape(uri)
          CGI.escape(uri)
        end
      end
      
      it "should escape the URI" do
        subject.instance_variable_get("@uri").to_s.
          should == "http%3A%2F%2Fgoogle.com%2F%3Fq%3Dstuff+and+stuff"
      end
    end
  end
  
end