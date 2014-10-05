=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "ruby/hooks/hook"

module Ruby
  module Hooks

    # Helper to add multiple instance hooks
    module InstanceHooks

      # define instance hook methog, it gives easy acces to Hook and
      # it's methods
      def define_hook(name, options = nil)
        define_method(name) do
          if hook = instance_variable_get(:"@#{name}")
          then return hook
          end
          hook = Ruby::Hooks::Hook.new(options)
          instance_variable_set(:"@#{name}", hook)
          hook
        end
      end

    end

  end
end

