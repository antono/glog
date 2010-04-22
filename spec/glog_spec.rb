require 'spec_helper'

describe "Glog" do

  it "should have config accessor" do
    Glog.config = 'config'
    Glog.config.should == 'config'
    Glog.config = nil
  end

  it "should respond to .env" do
    Glog.should respond_to(:env)
  end

end
