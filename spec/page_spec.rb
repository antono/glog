require 'spec_helper'

describe Glog::Page do

  before(:all) { Dir.chdir(FIXTURE_PATH) }

  describe "Page.root" do
    it "returns root page defined in Glog.config['root']" do
      expect(Glog::Page.root.title).to eq 'Hello All'
    end

    it "should return 'root' if Glog.config['root'] == 'nil'" do
      Glog.config = nil
      expect(File).to receive(:exist?).with('./glog.yaml').and_return(false)
      expect(Glog::Page.root.title).to eq 'Default Root Page'
    end
  end

  describe "#path_with_parent" do
    it "should return parent/name" do
      page = Glog::Page.first
      expect(page.path_with_parent).to eq File.join(page.parent, page.name)
    end
  end

  describe "#content_type" do
    it "shoud return text/html by default" do
      expect(Glog::Page.get('root').content_type).to eq 'text/html'
    end

    it "shoud return custom content type if provided in headers" do
      expect(Glog::Page.get('page-with-custom-content-type').content_type).to eq 'custom/type'
    end
  end
end
