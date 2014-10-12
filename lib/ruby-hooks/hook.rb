=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "observer"
require "ruby-hooks/extensible"

# Wrapper for Observable module
class RubyHooks::Hook
  include Observable
  include ::RubyHooks::Extensible

  # automatically extends Hook instance with given modules
  #
  # @option options [Array]  :extend array of modules to extend hook instance
  # @option options [Module] :extend module to extend hook instance
  def initialize(options = {})
    @options = options
    @observer_peers = {}
    add_plugins( :extend, options[:extends])
  end

  # allow writign code independent of the internals of Observable
  #
  # @return [Array] array of observers defined for the hook
  def observers
    @observer_peers
  end

  # convienience method to set changed state and notify observers in one call
  #
  # @param args [Array]     arguments to pass to +notify_observers+
  # @return     [nil|false] forwards result of +notify_observers+
  def changed_and_notify(*args)
    changed
    notify_observers(*args)
  end

end
