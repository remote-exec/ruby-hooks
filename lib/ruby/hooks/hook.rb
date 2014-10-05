=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "observer"
require "ruby/hooks/extensible"

module Ruby
  module Hooks

    # Wrapper for Observable module
    class Hook
      include Observable
      include ::Ruby::Hooks::Extensible

      def initialize(options = {})
        @options = options
        add_plugins( :extend, options[:extends])
      end

    end

  end
end
