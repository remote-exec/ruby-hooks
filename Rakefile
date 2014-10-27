=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

default_tasks = []

begin
  require "yard"
  YARD::Rake::YardocTask.new do |t|
    t.files   = ["lib/**/*.rb"]
    t.stats_options = ["--list-undoc", "--compact"]
  end

  task :docs    => [:yard]
  default_tasks << :yard
rescue LoadError
end

require "rake/testtask"
Rake::TestTask.new do |t|
  t.verbose = true
  t.libs.push("test")
  t.pattern = "test/**/*_test.rb"
end
default_tasks << :test

task :default => default_tasks
