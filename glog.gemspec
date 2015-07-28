Gem::Specification.new do |s|
  s.name = 'glog'
  s.version = File.read('VERSION')
  s.summary = %q{JADOF+Rack =  bogging/cms engine}
  s.description = %q{Static site generator and rack app}
  s.authors = ["Antono Vasiljev"]
  s.date = %q{2010-03-28}
  s.email = %q{antono.vasiljev@gmail.com}
  s.homepage = %q{http://github.com/antono/glog}
  s.licenses = ['MIT']
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.files = %w(lib/glog.rb lib/glog/page.rb lib/glog/server.rb lib/glog/template.rb lib/glog/env.rb)
  s.add_runtime_dependency("rack",      ["~> 1.6"])
  s.add_runtime_dependency("jadof",     ["~> 0.1"])
  s.add_runtime_dependency("haml",      ["~> 4.0"])
  s.add_runtime_dependency("rdiscount", ["~> 2.1"])
  s.add_development_dependency('rake',  ["~> 10.0"])
  s.add_development_dependency('rspec', ["~> 3.3"])
  s.add_development_dependency('rack-test', ["~> 0.6"])
end
