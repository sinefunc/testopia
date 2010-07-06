require 'rubygems'
require 'test/unit'
require 'contest'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'testopia'

class Test::Unit::TestCase
end

module FakeTestUnit
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def should(desc, &block)
      shoulds << [desc, block]
    end

    def shoulds
      @shoulds ||= []
    end
  end

  def assert(condition, message)
    asserts << [condition, message]
  end

  def asserts
    @asserts ||= []
  end

  def failed
    ! succeeded
  end

  def succeeded
    asserts.all? { |assert, message| !! assert }
  end

  def messages
    asserts.select { |assert, _| !assert }.map { |_, message| message }
  end

  def run
    self.class.shoulds.each do |desc, block|
      instance_eval(&block)
    end
  end
end
