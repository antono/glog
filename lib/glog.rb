require 'rubygems'

require 'yaml'
require 'glog/env'
require 'glog/page'
require 'glog/template'
require 'glog/server'

module Glog

  class << self
    attr_writer :config
    attr_accessor :env

    def config
      return @config if @config
      if File.exist?('./glog.yaml')
        @config ||= YAML.load_file('./glog.yaml')
      else
        @config = { 'root' => 'root' }
      end
    end
  end
end
