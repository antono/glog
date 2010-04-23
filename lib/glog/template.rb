require 'haml'

module Glog
  class Template

    include Haml

    attr_accessor :page, :locals, :template

    def self.wrap(page, locals = {})
      new(page, locals)
    end

    def initialize(page, locals = nil)
      @page   = page
      @locals = locals
      if page.template
        @template = File.read(build_template_path(page.template))
      else
        @template = find_for(page.path_with_parent)
      end
    end

    def render(path = nil, locals = {}, &block)
      template = path ? File.read("templates" + File::SEPARATOR + path + '.haml') : @template
      inner_html = block_given? ? yield : ''
      inner_html = inner_html == 0 ? '' : inner_html
      render_string(template, locals, inner_html)
    end

    def render_string(string, locals = {}, inner_html = '')
      Engine.new(string).render(self, @locals.merge(locals)) do
        render_string(inner_html)
      end
    end

    def find_for(page_path)
      template_path = possible_paths_for(page_path).detect { |path| File.exist?(path) }
      File.read template_path || 'templates/default.haml'
    end

    private

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
