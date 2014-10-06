=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "ruby/hooks"

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

class Observer3
  def test_me(x)
    x == 3
  end
end

class Observer4
  def test_me(x)
    x == 4
  end
end

describe Ruby::Hooks::Extensible do
  subject do
    Test2.new
  end

  it "uses extended method to find single observer" do
    subject.my_event_two.add_observer(Observer3.new, :test_me)
    subject.my_event_two.add_observer(Observer4.new, :test_me)
    subject.my_event_two.methods.map(&:to_sym).must_include :find_observer
    subject.my_event_two.changed
    subject.my_event_two.changed?.must_equal true
    subject.my_event_two.find_observer(1).must_be_nil
    subject.my_event_two.changed?.must_equal false
    subject.my_event_two.changed
    subject.my_event_two.find_observer(3).must_be_instance_of(Observer3)
    subject.my_event_two.changed
    subject.my_event_two.find_observer(4).must_be_instance_of(Observer4)
    subject.my_event_two.find_observer(4).must_be_nil
  end

end
