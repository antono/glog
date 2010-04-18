# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{glog}
  s.version = File.read('VERSION')
  s.summary = %q{Git powered bogging/cms engine}
  s.authors = ["Antono Vasiljev"]
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-03-28}
  s.email = %q{antono.vasiljev@gmail.com}
  s.homepage = %q{http://github.com/antono/glog}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.files = %w(lib/glog.rb lib/glog/page.rb lib/glog/server.rb lib/glog/template.rb lib/glog/env.rb)
  s.add_runtime_dependency("rack",   [">= 1.1.0"])
  s.add_runtime_dependency("jadof",  [">= 0.1.6"])
  s.add_runtime_dependency("haml",   [">= 2.2.22"])
  s.add_runtime_dependency("maruku", [">= 0.6.0"])
  s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
  s.add_development_dependency(%q<rack-test>, [">= 0.5.3"])
end
