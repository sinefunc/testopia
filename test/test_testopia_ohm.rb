require "helper"
require "ohm"
require "forwardable"
require "ohm/contrib"

class TestopiaOhmTest < Test::Unit::TestCase
  describe "the use of the subject word" do
    include Testopia::Ohm
    
    subject { "FooBar" }

    test "properly gets the value" do
      assert_equal "FooBar", subject
    end

    test "memoizes the value" do
      first  = subject
      second = subject

      assert_equal first.object_id, second.object_id
    end
  end

  describe "should_assert_error macro" do
    class SuccessfulContext1
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :name

        def validate
          assert name == 'FooBar', [:name, :not_foobar]
        end
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_error [:name, :not_foobar], :given => "NotFooBar"
    end

    test "properly determines the successful scenario" do
      context = SuccessfulContext1.new
      context.run
      
      assert context.succeeded
    end

    class FailedContext1
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :name
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_error [:name, :not_foobar], :given => "FooBar"
    end

    test "properly determines the failed scenario" do
      context = FailedContext1.new
      context.run
     
      assert context.failed
    end
  end
  
  describe "should_assert_present macro" do
    class FailedContext2
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :name
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_present :name
    end
   
    test "fails when no assert_present defined" do
      context = FailedContext2.new
      context.run
     
      assert context.failed
    end

    class SuccessfulContext2
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :name

        def validate
          assert_present :name
        end
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_present :name
    end
   
    test "succeeeds when assert_present defined" do
      context = SuccessfulContext2.new
      context.run
     
      assert context.succeeded
    end
  end

  describe "should_assert_numeric macro" do
    class FailedContext3
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :age
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_numeric :age
    end
   
    test "fails when no assert_present defined" do
      context = FailedContext3.new
      context.run
     
      assert context.failed
    end

    class SuccessfulContext3
      include FakeTestUnit

      class Person < Ohm::Model
        attribute :age

        def validate
          assert_numeric :age
        end
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_numeric :age
    end
   
    test "succeeeds when assert_present defined" do
      context = SuccessfulContext3.new
      context.run
     
      assert context.succeeded
    end
  end

  describe "should_assert_member macro" do
    class FailedContext4
      include FakeTestUnit

      class Person < Ohm::Model
        include Ohm::ExtraValidations

        attribute :gender
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_member :gender, ['Male', 'Female']
    end
   
    test "fails when no assert_present defined" do
      context = FailedContext4.new
      context.run
      
      assert context.failed
    end

    class SuccessfulContext5
      include FakeTestUnit

      class Person < Ohm::Model
        include Ohm::ExtraValidations

        attribute :gender

        def validate
          assert_member :gender, ['Male', 'Female']
        end
      end

      include Testopia::Ohm
      
      subject { Person.new }

      should_assert_member :gender, ["Male", "Female"], ["Fail", "Here"]
    end
   
    test "succeeeds when assert_present defined" do
      context = SuccessfulContext5.new
      context.run
     
      assert context.succeeded
    end
  end
end
