=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "ruby/hooks/hook"

# Helper to add multiple instance hooks
module Ruby::Hooks::InstanceHooks

  # define instance hook method, it gives easy acces to Hook and
  # it's methods
  #
  # @param name [Symbol] name of the hook handling method to define
  # @options options [Module] :extends - the module to extend hook instance
  # @return [Method or Symbol] exactly what method definition would return
  def define_hook(name, options = {})
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
