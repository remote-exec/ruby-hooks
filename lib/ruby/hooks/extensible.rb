=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

# Allow extending object with plugins(modules)
module Ruby::Hooks::Extensible

  # handle single parameters as well as arrays of params
  # @param method  [Symbol] name of the method to call
  # @param plugins [Array]  call method for every element of array
  # @param plugins [Object] call method for the object
  # @returns :nodoc: - unperdictable
  def add_plugins(method, plugins = nil)
    case plugins
    when Array then plugins.each { |plugin| send(method, plugin) }
    when nil   then true
    else            send(method, plugins)
    end
  end

end
