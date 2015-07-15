require 'spec_helper'

describe Glog::Server do

  include Rack::Test::Methods

  before(:all) { Dir.chdir(FIXTURE_PATH) }

  let(:app) { create_from_fixture('example') }

  describe "GET /" do
    it "should be ok" do
      get '/'
      expect(last_response).to be_ok
    end

    it "should render text from page defined as root in Glog.config" do
      get '/'
      expect(last_response.body).to match(/Hello All/)
    end
  end

  describe "GET /some/dir" do
    context "if index exist" do
      let(:dir) { 'pages/epo/2010' }
      it "should render /some/dir/index" do
        expect(File.exists?(dir)).to be true
        expect(File.directory?(dir)).to be true
        get '/epo/2010'
        expect(last_response).to be_ok
        expect(last_response.body).to match(/this is index/)
      end
    end

    context "if there is no index page" do
      it "should return 404 if no index found" do
        get '/nonexistent_page'
        expect(last_response).not_to be_ok
        expect(last_response.body).to match(/404/)
      end
    end
  end

  context "when page has custom content type" do
    it "should set content type to custom" do
      get '/page-with-custom-content-type'
      expect(last_response.content_type).to eq 'custom/type'
    end
  end

end
