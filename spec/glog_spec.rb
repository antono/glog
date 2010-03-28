require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Glog" do

  let(:app) { create_from_fixture('example') }

  it "should have config accessor" do
    Glog.config = 'config'
    Glog.config.should == 'config'
  end

  describe "Glog::Page" do
    describe "Page.root" do
      it "should return root page defined in Glog.config" do
        Glog::Page.root.title.should == 'Hello All'
      end
    end
    
    describe "#template_path" do
      describe "when template defined in file" do
        it "should return templates/{Page#template}.haml" do
          page = Glog::Page.get('template_test/template1_test')
          page.should_not be_nil
          page.template_path.should == 'templates/template1.haml'
        end
      end
      
      describe "when Page#template is undefined" do
        it "should should use default.html from tepmlates/{Page#parent}" do
          page = Glog::Page.get("template_test/undefined_template")
          page.parent.should == 'template_test'
          page.template_path.should == "templates/#{page.parent}/default.haml"
        end
        
        describe "if there is no defaut.html in templats/{Page#parent}" do
          it "should inherit default.html template from parent dirs" do
            page = Glog::Page.get("template_test/deep/template")
            page.parent.should == 'template_test/deep'
            page.template_path.should == "templates/template_test/default.haml"
            # And very deep page...
            page = Glog::Page.get("deep/deep/deep/page/with/undefined/template/here")
            page.parent.should == 'deep/deep/deep/page/with/undefined/template'
            page.template_path.should == "templates/default.haml"
          end
        end        
      end      
    end
  end

  describe "Glog::Server" do
    include Rack::Test::Methods
        
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
        get '/epo/2010'
        last_response.should be_ok
        last_response.body.should match(/this is index/)
      end
    end
  end # describe Server
end # describe Glog