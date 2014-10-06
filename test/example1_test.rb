=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "ruby/hooks"

class Test1
  extend Ruby::Hooks::InstanceHooks
  define_hook(:my_event_one)
end

class Observer1
  attr_accessor :result
  def update(x)
    @result = x
  end
end

class Observer2
  attr_accessor :result
  def log(x)
    @result = x
  end
end

describe Ruby::Hooks::Extensible do
  subject do
    Test1.new
  end

  before do
    @object1 = Observer1.new
    @object2 = Observer2.new
  end

  it "uses extended method to find single observer" do
    subject.my_event_one.add_observer(@object1)
    subject.my_event_one.add_observer(@object2, :log)
    subject.my_event_one.changed
    subject.my_event_one.notify_observers("msg")
    @object1.result.must_equal("msg")
    @object2.result.must_equal("msg")
  end

end
