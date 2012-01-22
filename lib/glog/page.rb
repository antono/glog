require 'jadof'
require 'rdiscount'

module Glog
  class Page < JADOF::Page

    DEFAULT_FORMATTERS['markdown'] = lambda { |text|
      RDiscount.new(text, :smart).to_html
    }

    def self.root
      get(Glog.config['root'])
    end

    def render
      self.template == false ? super : wrap_with_template(super)
    end

    def path_with_parent
      File.join(parent, name)
    end

    def content_type
      self.ctype ? self.ctype : 'text/html'
    end
  end
end
