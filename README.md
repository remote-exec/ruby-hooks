# Ruby Hooks

[![Gem Version](https://badge.fury.io/rb/ruby-hooks.png)](https://rubygems.org/gems/ruby-hooks)
[![Build Status](https://secure.travis-ci.org/remote-exec/ruby-hooks.png?branch=master)](https://travis-ci.org/remote-exec/ruby-hooks)
[![Dependency Status](https://gemnasium.com/remote-exec/ruby-hooks.png)](https://gemnasium.com/remote-exec/ruby-hooks)
[![Code Climate](https://codeclimate.com/github/remote-exec/ruby-hooks.png)](https://codeclimate.com/github/remote-exec/ruby-hooks)
[![Coverage Status](https://img.shields.io/coveralls/remote-exec/ruby-hooks.svg)](https://coveralls.io/r/remote-exec/ruby-hooks?branch=master)
[![Docs Coverage](http://inch-ci.org/github/remote-exec/ruby-hooks.png)](http://inch-ci.org/github/remote-exec/ruby-hooks)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/remote-exec/ruby-hooks/master/frames)
[![Github Code](http://img.shields.io/badge/github-code-blue.svg)](https://github.com/remote-exec/ruby-hooks)

Helpers for multiple publish/subscribe hooks using
[Rubys Observable][rubys_observable].

## Installation

Install manually:

    gem install ruby-hooks

Or add to `Gemfile`:

    gem "ruby-hooks"

and install with:

    bundle install

## Usage

```ruby
require "ruby/hooks"

class Test1
  extend RubyHooks::InstanceHooks
  define_hook(:my_event_one)
end
test = Test1.new
test.my_event_one # => RubyHooks::Hook
```

`Hook` has all methods of [Rubys Observable][rubys_observable] use it
like this:

```ruby
test.my_event_one.add_observer(object1)       # changes will call object1.update
test.my_event_one.add_observer(object2, :log) # changes will call object2.log
test.my_event_one.change                      # mark as changed, can be called multiple times
test.my_event_one.notify_observers(*args)     # run the observers methods with given args
test.my_event_one.change_and_notify(*args)    # mark as changed and run the observers methods with given args
```

## Documenting the hooks

`ruby-hooks` comes with a support gem that allows to write `yard` docs
for the hooks.

To automatically use the plugin add `--plugin ruby-hooks` to projects
root directory `.yardopts` file.

Example documentation:

```ruby
# called before executing command
# @notify_param object [Object] the target that invoked the method
# @notify_param stdout [String] standard output of the command, can be nil
# @notify_param stderr [String] standard error output of the command, can be nil
define_hook :on_execute_data
```

All hooks will be listed in `Hooks` section of the documentation, and
the generated hook description will look roughly like this:

```markdown
` - (Hook) on_execute_data`

called before executing command

**Returns:**

- (`Hook`) — the Observable instance

Hook#notify_observers block params:

- **object** (`Object`) — the target that invoked the method
- **stdout** (`String`) — standard output of the command, can be nil
- **stderr** (`String`) — standard error output of the command, can be nil
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
  extend RubyHooks::InstanceHooks
  define_hook(:my_event_two, :extends => FindObserver)
end
Test2.new.my_event_two.find_observer(*args)
```

this way users are not limited by the standard functionalities of
[Rubys Observable][rubys_observable].

## Defining the function manually

`define_hook` is just a small wrapper equivalent to:


```ruby
require "ruby/hooks/hook"

def my_hook
  @my_hook ||= RubyHooks::Hook.new(:extends => MyAwesomeModule)
end
```

It's more code and less magic, to exclude `ruby-hooks` this should work:

```ruby
require "observer"

def my_hook
  @my_hook ||= Object.new.tap do |hook|
    hook.extend Observable
    hook.extend MyAwesomeModule
  end
end
```

It has certain limitation - all the hooks will be of class `Object`, it
makes reading code and backtraces harder and you can not use the
documentation helper with `@notify_param`.

## Compatibility

This librarys is tested with ruby `1.9.2+`, `jruby` and `rbx`.

[rubys_observable]: http://ruby-doc.org/stdlib-1.9.3/libdoc/observer/rdoc/Observable.html
