Testopia
========
Testing is cool, but sometimes, you have to gauge the ROI of everything you do, 
especially if the project is on a tight budget, and you know that every hour
hurts your clients' pockets.

No tests aren't good either. The answer? Test lazily. (This ain't new btw, but
it's new in the space of monk / ohm / sinatra afaik)

Examples?
---------
    
    # To clarify, Order is an Ohm model using it's assert_* assertions

    class OrderTest < Test::Unit::TestCase
      subject { Order.new }

      should_assert_present :amount, :description
      should_assert_numeric :amount

      # or you can do some generic validation assertions
      should_assert_error [:status, :invalid], :given => "FooBared"
    end
  
    # Another example for users
    class UserTest < Test::Unit::TestCase
      subject { User.new }

      should_assert_present :email, :password, :first_name, :last_name
      should_assert_error [:password, :not_confirmed], :given => 'pass'
      should_assert_error [:email, :not_email], :given => 'notemail'
    end

    # I also added should_assert_member, which works if you have Ohm::Contrib 
    # in your model
    require 'ohm/contrib'

    class Order
      include Ohm::ExtraValidations

      attribute :state

      def validate
        should_assert_member :state, %w{pending authorized declined}
      end
    end

    class OrderTest < Test::Unit::TestCase
      subject { Order.new }

      should_assert_member :state, %w{pending authorized declined}

      # You can even explicitly specify values for which it _should_ fail
      should_assert_member :state, %w{pending authorized declined}, %w{Foo Bar}
    end

### Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a 
  commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

### Copyright

Copyright (c) 2010 Cyril David. See LICENSE for details.
