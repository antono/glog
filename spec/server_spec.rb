describe Glog::Server do

  include Rack::Test::Methods

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
    it "should try to render /some/dir/index if index exists" do
      dir = 'spec/fixtures/example/pages/epo/2010'
      File.exists?(dir).should be_true
      File.directory?(dir).should be_true
      get '/epo/2010'
      last_response.should be_ok
      last_response.body.should match(/this is index/)
    end

    it "should return 404 if no index found" do
      get '/nonexistent_page'
      last_response.should_not be_ok
      last_response.body.should match(/404/)
    end
  end

end # describe Server