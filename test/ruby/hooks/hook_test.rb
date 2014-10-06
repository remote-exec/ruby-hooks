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

  it "extends self" do
    subject.methods.map(&:to_sym).wont_include :method_2
    subject.send :initialize, :extends => HookTestClass::Extra
    subject.methods.map(&:to_sym).must_include :method_2
  end

end
