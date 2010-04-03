require 'haml'

module Glog
  class Template

    include Haml
    
    attr_accessor :page, :locals, :template

    def self.wrap(page, locals = {})
      new(page, locals)
    end

    def initialize(page, locals = nil)
      @page      = page
      @locals    = locals
      if page.template
        @template = File.read(build_template_path(page.template))
      else
        @template = find_for(page.path_with_parent)
      end
    end

    def render(path = nil)
      template = path ? File.read("templates" + File::SEPARATOR + path + '.haml') : @template
      render_string(template, @locals)
    end

    private

    def render_string(string, locals = {})
      Engine.new(string).render(self, @locals)
    end

    def find_for(page_path)
      puts "Searching for #{page_path}"
      puts "Possible paths: #{possible_paths_for(page_path).to_yaml}"
      template_path = possible_paths_for(page_path).detect { |path| File.exist?(path) }
      puts "Matched template: #{template_path}"
      File.read template_path || 'templates/default.haml'
    end

    def possible_paths_for(page_path)
      return [] if page_path.nil?
      segments = page_path.split(File::SEPARATOR)
      paths = [] << build_template_path(segments) # twin template
      segments.size.downto(1) do |ix|
        segments.pop
        paths.push build_template_path(segments[0..ix] + ['default'])
      end
      paths
    end

    def build_template_path(path)
      ["templates", path].flatten.join(File::SEPARATOR) + '.haml'
    end

  end
end
