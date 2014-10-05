=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

default_tasks = []

begin
  require "yard"
  YARD::Rake::YardocTask.new do |t|
    t.files   = ["lib/**/*.rb"]
    # TODO: see https://github.com/lsegal/yard/pull/800
    #~ t.stats_options = ["--list-undoc", "--compact"]
    t.options = ["--no-stats"]
    t.after = Proc.new do
      YARD::CLI::Stats.new.run("--list-undoc", "--compact", "--use-cache")
    end
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
