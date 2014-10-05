=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "observer"

module Ruby
  module Hooks

    # Allow extending object with plugins(modules)
    module Extensible

      def add_plugins(method, plugins = nil)
        case plugins
        when Array  then plugins.each { |plugin| send(method, plugin) }
        when nil    then true
        else             send(method, plugins)
        end
      end

    end

  end
end

