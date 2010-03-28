module Glog
  class Page < JADOF::Page
    def self.root
      get(Glog.config['root'])
    end
    
    def render
      self.template == false ? super : wrap_with_template(super)
    end
    
    def template_path
      if self.template
        "templates/#{self.template}.haml"
      else self.parent.size > 0
        detect_template_from_parent
      end
    end
    
    def detect_template_from_parent
      first_match = false
      segments = self.parent.split(File::SEPARATOR)
      segments.size.times do |i|
        template_path = (['templates'] + segments[0..-(i-1)] + ['default.haml']).join(File::SEPARATOR)
        if File.exists?(template_path)
          first_match = template_path
          break
        end
        segments.pop
      end
      first_match || 'templates/default.haml'
    end
    
    private

    def wrap_with_template(content)
      locals = { :page => self, :config => Glog.config, :pages => self.class }
      Haml::Engine.new(File.read(template_path)).to_html(nil, locals)
    end
    
  end
end