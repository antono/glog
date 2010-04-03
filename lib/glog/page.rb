require 'jadof'

module Glog
  class Page < JADOF::Page

    def self.root
      get(Glog.config['root'])
    end
    
    def render
      self.template == false ? super : wrap_with_template(super)
    end
    
    def path_with_parent
      File.join(parent, name)
    end
    
  end
end