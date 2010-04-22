require 'spec_helper'

describe Glog::Page do
  describe "Page.root" do
    it "should return root page defined in Glog.config['root']" do
      Glog::Page.root.title.should == 'Hello All'
    end

    it "should return 'root' if  Glog.config['root'] == 'nil'" do
      File.should_receive(:exist?).with('glog.yaml').and_return(false)
      Glog::Page.root.title.should == 'Default Root Page'
    end
  end

  describe "#path_with_parent" do
    it "should return parent/name" do
      page = Glog::Page.first
      page.path_with_parent.should == File.join(page.parent, page.name)
    end
  end
end
