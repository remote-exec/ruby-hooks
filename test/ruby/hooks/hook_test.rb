=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "ruby/hooks/hook"

class HookTestClass
  module Extra
    def method_2
    end
  end
  class Update
    attr_reader :value
    def update(value)
      @value = value
    end
  end
end

describe Ruby::Hooks::Hook do
  subject do
    Ruby::Hooks::Hook.allocate
  end

  it "is based on Observable" do
    subject.must_be_kind_of(Observable)
  end

  it "initializes without params" do
    subject.send :initialize
    subject.methods.map(&:to_sym).wont_include :method_2
  end

  describe "observer interaction" do

    let(:observer) do
      HookTestClass::Update.new
    end

    it "gives access to observers" do
      subject.send :initialize
      subject.methods.map(&:to_sym).must_include :observers
      subject.observers.must_be_empty
      subject.add_observer(observer)
      subject.observers.must_equal({observer => :update})
    end

    it "allows fast execution" do
      subject.send :initialize
      subject.methods.map(&:to_sym).must_include :changed_and_notify
      subject.add_observer(observer)
      subject.changed_and_notify(7)
      observer.value.must_equal(7)
    end

  end # context "observer interaction"

  it "extends self" do
    subject.methods.map(&:to_sym).wont_include :method_2
    subject.send :initialize, :extends => HookTestClass::Extra
    subject.methods.map(&:to_sym).must_include :method_2
  end

end
