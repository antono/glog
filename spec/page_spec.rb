require 'spec_helper'

describe Glog::Page do
  describe "Page.root" do
    it "should return root page defined in Glog.config" do
      Glog::Page.root.title.should == 'Hello All'
    end
  end

  describe "#path_with_parent" do
    it "should return parent/name" do
      page = Glog::Page.first
      page.path_with_parent.should == File.join(page.parent, page.name)
    end
  end
end