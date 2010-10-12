require 'spec_helper'

describe Glog::Page do

  before(:all) { Dir.chdir(FIXTURE_PATH) }

  describe "Page.root" do
    it "should return root page defined in Glog.config['root']" do
      Glog::Page.root.title.should == 'Hello All'
    end

    it "should return 'root' if  Glog.config['root'] == 'nil'" do
      Glog.config = nil
      File.should_receive(:exist?).with('./glog.yaml').and_return(false)
      Glog::Page.root.title.should == 'Default Root Page'
    end
  end

  describe "#path_with_parent" do
    it "should return parent/name" do
      page = Glog::Page.first
      page.path_with_parent.should == File.join(page.parent, page.name)
    end
  end

  describe "#content_type" do
    it "shoud return text/html by default" do
      Glog::Page.get('root').content_type.should == 'text/html'
    end
    it "shoud return custom content type if provided in headers" do
      Glog::Page.get('page-with-custom-content-type').content_type.should == 'custom/type'
    end
  end
end
