require 'test/unit'
require '../lib/bike/bike.rb'

class TestBike < MiniTest::Unit::TestCase

  def test_new_bike_is_not_broken
    bike = Bike.new(1)
    assert bike.broken? == false
  end

  def test_bike_can_be_broken
    bike = Bike.new(1)
    bike.break!
    assert bike.broken? == true
  end

  def test_bike_can_be_fixed
    bike = Bike.new(1)
    bike.break!
    bike.fix!
    assert bike.broken? == false
  end

  def test_bike_has_an_id
    bike = Bike.new(1)
    assert_equal 1, bike.id
  end

end