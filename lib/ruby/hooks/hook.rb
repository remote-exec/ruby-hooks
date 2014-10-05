require "observer"

module Ruby
  module Hooks

    # Wrapper for Observable module
    class Hook
      include Observable
      include Extensible

      def initialize(options = {})
        @options = options
        add_plugins( :extend, options[:extends])
      end

    end

  end
end

