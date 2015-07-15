require 'spec_helper'

describe "Glog" do

  it "should have config accessor" do
    Glog.config = 'config'
    expect(Glog.config).to eq 'config'
    Glog.config = nil
  end

end
