require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |g|
    g.name = 'kitsune'
    g.summary = %(Integrated Rails Content Management System.)
    g.description = %(Integrated Rails Content Management System.)
    g.email = 'matt@toastyapps.com'
    g.homepage = 'http://github.com/toastyapps/kitsune'
    g.authors = %w(toastyapps <matt@toastyapps.com>)
    g.requirements << "will_paginate"
    g.requirements << "haml"
    g.add_dependency('will_paginate', '~> 2.3.11')
    g.add_dependency('haml', '~> 2.2.12')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end
 
Rake::TestTask.new do |t|
  t.libs = %w(test)
  t.pattern = 'test/**/*_test.rb'
end
 
task :default => :test