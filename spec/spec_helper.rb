$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'glog'
require 'rspec'
require 'rspec/autorun'
#require 'rspec/interop/test'
require 'rack/test'

require 'pp'

def create_from_fixture(name)
  Dir.chdir(File.join(File.dirname(__FILE__), "fixtures", name))
  Glog.config = YAML.load_file('glog.yaml')
  @app = Glog::Server.new
end

#RSpec::Runner.configure do |config|
#end
