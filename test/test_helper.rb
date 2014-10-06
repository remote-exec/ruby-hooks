=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "rubygems"

if
  RUBY_VERSION == "2.0.0" && # check Gemfile
  $0 != "-e" # do not do that in guard
then
  require "coveralls"
  require "simplecov"

  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter,
    ]
    command_name "Unit Tests"
    add_filter "/test/"
  end

  Coveralls.noisy = true unless ENV["CI"]
end

# Autoload all lib/**/*.rb files so simplecov does not misses anything
Dir[File.expand_path("../../lib/**/*.rb", __FILE__)].each{|f| require f }

require "minitest/autorun" unless $0=="-e" # skip in guard
require "minitest/unit"

