require "observer"

module Ruby
  module Hooks

    # Allow extending object with plugins(modules)
    module Extensible

      def add_plugins(method, plugins)
        case plugins
        when Array  then plugins.each { |plugin| send(method, plugin) }
        when Module then send(method, plugins)
        when nil    then true
        else raise "Do not know how to handle #{method} plugins: #{extends.inspect}"
        end
      end

    end

  end
end

