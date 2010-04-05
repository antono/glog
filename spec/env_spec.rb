require 'spec_helper'

describe Glog::Env do

  let(:env) { Glog::Env.new({}) }

  describe "#development?" do
    it "should return true if RACK_ENV == development" do
      ENV['RACK_ENV'] = 'development'
      env.should be_development
      ENV['RACK_ENV'] = 'other'
      env.should_not be_development
    end
  end

  describe "#production?" do
    it "should return true if RACK_ENV == production" do
      ENV['RACK_ENV'] = 'production'
      env.should be_production
      ENV['RACK_ENV'] = 'other'
      env.should_not be_production
    end
  end

end