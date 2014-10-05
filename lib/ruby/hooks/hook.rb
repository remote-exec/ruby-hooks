=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "observer"
require "ruby/hooks/extensible"

# Wrapper for Observable module
class Ruby::Hooks::Hook
  include Observable
  include ::Ruby::Hooks::Extensible

  # automatically extends Hook instance with given modules
  # @options options [Array]  :extend array of modules to extend hook instance
  # @options options [Module] :extend module to extend hook instance
  def initialize(options = {})
    @options = options
    add_plugins( :extend, options[:extends])
  end

  # allow writign code independent of the internals of Observable
  def observers
    @observer_peers
  end

end
