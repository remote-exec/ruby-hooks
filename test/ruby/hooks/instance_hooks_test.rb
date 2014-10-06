=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "ruby/hooks/instance_hooks"

class InstanceHooksTestClass
  module Extra
    def method3
    end
  end
  extend Ruby::Hooks::InstanceHooks
  define_hook(:test1)
  define_hook(:test2, :extends => Extra)
end

describe Ruby::Hooks::Extensible do
  subject do
    InstanceHooksTestClass.new
  end

  it "defines and extends hooks" do
    subject.methods.map(&:to_sym).must_include :test1
    subject.methods.map(&:to_sym).must_include :test2
    subject.test2.methods.map(&:to_sym).must_include :method3
  end

  it "reuses existing hook" do
    subject.test2.must_equal subject.test2
  end

end
