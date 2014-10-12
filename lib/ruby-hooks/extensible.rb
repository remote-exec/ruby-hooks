=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "ruby-hooks/version"

# Allow extending object with plugins(modules)
module RubyHooks::Extensible

  # handle single parameters as well as arrays of params
  # @param method  [Symbol]        name of the method to call
  # @param plugins [Object|Array]  call method for object or every element of array
  def add_plugins(method, plugins = nil)
    case plugins
    when Array then plugins.each { |plugin| send(method, plugin) }
    when nil   then true
    else            send(method, plugins)
    end
  end

end
