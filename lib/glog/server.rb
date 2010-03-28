module Glog
  class Server
        
    def call(env)
      env['PATH_INFO'] == '/' ? send_root_page : send_path(env['PATH_INFO'])
    end
    
    private

    def send_path(path)
      path = path[1..-1] # /my/page => my/page
      # First trying to load page
      if page = Page.get(path)
        send_page(page)
      # Then trying to load directory index if any
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
      [200, { 'Content-Type' => 'text/html' }, page.render]
    end
    
    def send_not_found
      [404, { 'Content-Type' => 'text/html'}, '404 Not Found']
    end
    
    def send_root_page
      Page.root ? send_page(Page.root) : send_not_found
    end
  end # Server
end # Glog