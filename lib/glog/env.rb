module Glog
  class Env

    def initialize(env)
      @env = env
    end

    def path
      @env['PATH_INFO']
    end

    def path?(other)
      path == other
    end

    def development?
      ENV['RACK_ENV'] == 'development'
    end

    def production?
      ENV['RACK_ENV'] == 'production'
    end
  end
end
