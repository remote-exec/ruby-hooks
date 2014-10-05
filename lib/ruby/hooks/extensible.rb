=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

# Allow extending object with plugins(modules)
module Ruby::Hooks::Extensible

  # handle single parameters as well as arrays of params
  # @params method  [Symbol] name of the method to call
  # @params plugins [Array]  call method for every element of array
  # @params plugins [Object] call method for the object
  # @returns - unperdictable
  def add_plugins(method, plugins = nil)
    case plugins
    when Array then plugins.each { |plugin| send(method, plugin) }
    when nil   then true
    else            send(method, plugins)
    end
  end

end
