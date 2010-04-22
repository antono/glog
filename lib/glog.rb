require 'rubygems'

require 'glog/env'
require 'glog/page'
require 'glog/template'
require 'glog/server'

module Glog

  @@config = nil
  @@env    = nil

  def self.config
    if File.exist?('glog.yaml')
      @@config ||= YAML.load_file('glog.yaml')
    else
      @@config = { 'root' => 'root' }
    end
    @@config
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
