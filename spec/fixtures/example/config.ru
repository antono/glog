$: << '../../../lib'
require 'glog'
require 'sass/plugin/rack'

use Rack::Static, :urls => ['/stylesheets', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'dev'
  use Rack::Reloader
  use Rack::ShowExceptions
end

use Sass::Plugin::Rack
Sass::Plugin.options.merge(
  :cache_location => "/tmp/glog.sass-cache.#{rand(10000)}",
  :never_update => ENV['RACK_ENV'] != 'dev',
  :full_exception => ENV['RACK_ENV'] == 'dev')

run Glog::Server.new
