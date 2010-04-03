require 'rubygems'

require 'glog/env'
require 'glog/page'
require 'glog/template'
require 'glog/server'

module Glog

  @@config = nil
  @@env    = nil

  def self.config
    @@config ||= YAML.load_file('glog.yaml')
  end
  
  def self.config=(config)
    @@config = config
  end
  
  def self.env
    @@env
  end
  
  def self.env=(env)
    @@env = env
  end

end