require 'test/unit'
require '../lib/dockable.rb'
require '../lib/bike.rb'
require '../lib/garage'

class TestGarage < MiniTest::Unit::TestCase

  def test_can_fix_many_bikes
    garage = Garage.new

    20.times do |i|
      bike = Bike.new(i)
      bike.break!
      garage.dock(bike) #=> garage.bikes
    end
    assert 0, garage.available_bikes.count
    garage.fix!
    assert 20, garage.available_bikes.count

  end

end