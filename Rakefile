require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
  
    # Description
    gem.name          = "glog"
    gem.summary       = %Q{Git powered bogging engine}
    gem.description   = %Q{Blog your git repository}
    gem.email         = "antono.vasiljev@gmail.com"
    gem.homepage      = "http://github.com/antono/glog"
    gem.authors       = ["Antono Vasiljev"]
    
    # Dendencies
    gem.add_dependency             "jadof",     ">= 0.1.6"
    gem.add_dependency             "haml",      ">= 2.2.0"
    gem.add_development_dependency "rspec",     ">= 1.3.0"
    gem.add_development_dependency "rack-test", ">= 0.5.3"

    # see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "glog #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end