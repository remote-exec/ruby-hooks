=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "ruby-hooks/extensible"

class ExtensibleTestClass
  include RubyHooks::Extensible
  attr_reader :calls
  def initialize
    @calls = []
  end
  def count(name)
    @calls << name
  end
  module Extra
    def method_1
    end
  end
  module Test1
  end
  module Test2
  end
  module Test3
  end
end

describe RubyHooks::Extensible do
  subject do
    ExtensibleTestClass.new
  end

  it "extends self" do
    subject.methods.map(&:to_sym).wont_include :method_1
    subject.add_plugins :extend, ExtensibleTestClass::Extra
    subject.methods.map(&:to_sym).must_include :method_1
    subject.calls.must_be_empty
  end

  it "calls single element" do
    subject.add_plugins :count, ExtensibleTestClass::Test1
    subject.calls.must_equal [ExtensibleTestClass::Test1]
  end

  it "calls each element" do
    subject.add_plugins :count, [ExtensibleTestClass::Test1, ExtensibleTestClass::Test2, ExtensibleTestClass::Test3]
    subject.calls.must_equal [ExtensibleTestClass::Test1, ExtensibleTestClass::Test2, ExtensibleTestClass::Test3]
  end

  it "calls nothing" do
    subject.add_plugins :count
    subject.calls.must_equal []
  end

end
