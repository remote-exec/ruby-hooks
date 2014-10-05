=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "observer"

module Ruby
  module Hooks

    class UnsupportedPlugin < Exception
    end

    # Allow extending object with plugins(modules)
    module Extensible

      def add_plugins(method, plugins = nil)
        case plugins
        when Array  then plugins.each { |plugin| send(method, plugin) }
        when Module then send(method, plugins)
        when nil    then true
        else raise UnsupportedPlugin, "Do not know how to handle #{method} plugins: #{plugins.inspect}"
        end
      end

    end

  end
end

