require 'rack'

module Glog
  class Server

    def call(rack_env)
      Glog.env = Env.new(rack_env)
      Glog.env.path?('/') ? send_root_page : send_path(Glog.env.path)
    end

    private

    def send_path(path)
      path = path[1..-1] # /my/page => my/page
      if page = Page.get(path)
        send_page(page)
      elsif page = try_dir_index(path)
        send_page(page)
      else
        send_not_found
      end
    end

    def try_dir_index(path)
      File.directory?(File.join('pages', path))
      Page.get(File.join(path, 'index'))
    end

    def send_page(page)
      [200, { 'Content-Type' => ( page.content_type || 'text/html' ) }, [ render_page(page) ]]
    end

    def send_not_found
      [404, { 'Content-Type' => 'text/html' }, [ '404 Not Found' ]]
    end

    def send_root_page
      Page.root ? send_page(Page.root) : send_not_found
    end

    def render_page(page)
      locals = { :env => Glog.env, :config => Glog.config, :pages => Page }
      Template.wrap(page, locals).render
    end

  end # Server
end # Glog
