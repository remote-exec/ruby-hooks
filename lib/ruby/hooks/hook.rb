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

  def initialize(options = {})
    @options = options
    add_plugins( :extend, options[:extends])
  end

  # allow writign code independent of the internals of Observable
  def observers
    @observer_peers
  end

end
