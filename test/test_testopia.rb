require 'helper'

class TestTestopia < Test::Unit::TestCase
  test "autoloading of Ohm" do
    assert_nothing_raised LoadError, NameError do
      Testopia::Ohm
    end
  end

  test "autoloading of ActiveMerchant" do
    assert_nothing_raised LoadError, NameError do
      Testopia::ActiveMerchant
    end
  end
end
