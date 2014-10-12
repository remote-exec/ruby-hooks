#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# stub: ruby-hooks ruby lib

=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "ruby-hooks/version"

Gem::Specification.new do |spec|
  spec.name        = "ruby-hooks"
  spec.version     = ::RubyHooks::VERSION
  spec.licenses    = ["MIT"]

  spec.authors     = ["Michal Papis"]
  spec.email       = ["mpapis@gmail.com"]

  spec.homepage    = "https://github.com/remote-exec/ruby-hooks"
  spec.summary     =
  spec.description = "Helpers for multiple publish/subscribe hooks"

  spec.add_dependency("yard-ruby-hooks", "~>1.0")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("minitest")

  spec.files        = Dir.glob("lib/**/*.rb")
  spec.test_files   = Dir.glob("test/**/*.rb")
end
