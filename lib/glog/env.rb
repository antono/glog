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
  end
end
