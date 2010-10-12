$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'glog'
require 'rspec'
require 'rack/test'

require 'pp'

FIXTURE_PATH = File.join(File.dirname(File.expand_path(__FILE__)), "fixtures", 'example')

def create_from_fixture(name)
  Dir.chdir(FIXTURE_PATH)
  Glog.config = YAML.load_file('glog.yaml')
  @app = Glog::Server.new
end
