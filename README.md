# Ruby Hooks

[![Gem Version](https://badge.fury.io/rb/ruby-hooks.png)](https://rubygems.org/gems/ruby-hooks)
[![Build Status](https://secure.travis-ci.org/remote-exec/ruby-hooks.png?branch=master)](https://travis-ci.org/remote-exec/ruby-hooks)
[![Dependency Status](https://gemnasium.com/remote-exec/ruby-hooks.png)](https://gemnasium.com/remote-exec/ruby-hooks)
[![Code Climate](https://codeclimate.com/github/remote-exec/ruby-hooks.png)](https://codeclimate.com/github/remote-exec/ruby-hooks)
[![Coverage Status](https://img.shields.io/coveralls/remote-exec/ruby-hooks.svg)](https://coveralls.io/r/remote-exec/ruby-hooks?branch=master)
[![Inline docs](http://inch-ci.org/github/remote-exec/ruby-hooks.png)](http://inch-ci.org/github/remote-exec/ruby-hooks)

Helpers for multiple publish/subscribe hooks using
[Rubys Observable][rubys_observable].

## Installation

Install manually:

    gem install ruby-hooks

Or add to `Gemfile`:

    gem 'ruby-hooks'

and install with:

    bundle install

## Usage

```ruby
require 'ruby/hooks'

class Test1
  extend Ruby::Hooks::InstanceHooks
  define_hook(:my_event_one)
end
test = Test1.new
test.my_event_one # => Ruby::Hooks::Hook
```

`Hook` has all methods of [Rubys Observable][rubys_observable] use it
like this:

```ruby
test.my_event_one.add_observer(object1)       # changes will call object1.update
test.my_event_one.add_observer(object2, :log) # changes will call object2.log
test.my_event_one.change                      # mark as changed, can be called multiple times
test.my_event_one.notify_observers(*args)     # run the observers methods with given args
```

## Writing your own notifier

Default `notify_observers` has no feedback in regard if the calls
succeeded, it is very simple to extend `Hook` using:

```ruby
module FindObserver
  def find_observer(*arg)
    result = nil
    if changed?
      if observers
        result =
        observers.find do |k, v|
          k.send v, *arg
        end
      end
      changed(false)
    end
    result and result.first
  end
end
class Test2
  extend Ruby::Hooks::InstanceHooks
  define_hook(:my_event_two, :extends => FindObserver)
end
Test2.new.my_event_two.find_observer(*args)
```
this way users are not limited by the standard functionalities of
[Rubys Observable][rubys_observable].

[rubys_observable]: http://ruby-doc.org/stdlib-1.9.3/libdoc/observer/rdoc/Observable.html
