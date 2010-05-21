module Testopia
  module Ohm
    def self.included(base)
      base.extend Macros
    end

    module Macros
      def subject(&block)
        define_method :subject do
          @__subject__ ||= block.call 
        end
      end
      
      def should_assert_error(pair, options = {})
        value        = options[:given]
        field, error = pair

        should 'assert %s of %s' % [error, field] do
          subject.send '%s=' % field, value

          assert ! subject.valid?, '%s should not be valid' % subject.inspect
          assert subject.errors.include?(pair),
            '%s should have a %s error' % [field, error]
        end
      end

      def should_assert_present(*atts)
        atts.each { |a| should_assert_error [a, :not_present], :given => nil }
      end

      def should_assert_numeric(*atts)
        atts.each { |a| should_assert_error [a, :not_numeric], :given => 'aa' } 
      end

      def should_assert_member(att, set, invalid = '_SOME_FOOBAR_VALUE_')
        should_assert_error [att, :not_member], :given => invalid

        set.each do |elem|
          should "assert_member :%s, %s" % [att, elem] do
            subject.send '%s=' % att, elem
            subject.valid?

            assert ! subject.errors.include?([att, :not_member]),
              '%s expected to be valid with "%s"' % [att, elem]
          end
        end
      end
    end
  end
end
