require 'rubygems'
require 'rack'
require 'jadof'
require 'haml'
require 'glog/page'
require 'glog/server'

module Glog

  @@config = nil

  def self.config
    @@config ||= YAML.load_file('glog.yaml')
  end
  
  def self.config=(config)
    @@config = config
  end

end