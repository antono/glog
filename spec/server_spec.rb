require 'spec_helper'

describe Glog::Server do

  include Rack::Test::Methods

  before(:all) { Dir.chdir(FIXTURE_PATH) }

  let(:app) { create_from_fixture('example') }

  describe "GET /" do
    it "should be ok" do
      get '/'
      last_response.should be_ok
    end

    it "should render text from page defined as root in Glog.config" do
      get '/'
      last_response.body.should =~ /Hello All/
    end
  end

  describe "GET /some/dir" do
    context "if index exist" do
      let(:dir) { 'pages/epo/2010' }
      it "should render /some/dir/index" do
        expect(File.exists?(dir)).to be true
        expect(File.directory?(dir)).to be true
        get '/epo/2010'
        last_response.should be_ok
        last_response.body.should match(/this is index/)
      end
    end

    context "if there is no index page" do
      it "should return 404 if no index found" do
        get '/nonexistent_page'
        last_response.should_not be_ok
        last_response.body.should match(/404/)
      end
    end
  end

  context "when page has custom content type" do
    it "should set content type to custom" do
      get '/page-with-custom-content-type'
      last_response.content_type.should == 'custom/type'
    end
  end

end
