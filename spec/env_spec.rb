require 'spec_helper'

describe Glog::Env do

  let(:env) { Glog::Env.new({}) }

  describe "#development?" do
    it "should return true if RACK_ENV == development" do
      ENV['RACK_ENV'] = 'development'
      expect(env.development?).to be true
      ENV['RACK_ENV'] = 'other'
      expect(env.production?).not_to be true
    end
  end

  describe "#production?" do
    it "should return true if RACK_ENV == production" do
      ENV['RACK_ENV'] = 'production'
      expect(env.production?).to be true
      ENV['RACK_ENV'] = 'other'
      expect(env.production?).not_to be true
    end
  end

end
