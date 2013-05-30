require 'test/unit'
require '../lib/bike.rb'
require '../lib/dockable.rb'
require '../lib/docking_station.rb'

class TestDockingStation < MiniTest::Unit::TestCase

  def test_default_capacity
    station = DockingStation.new
    assert_equal 20, station.capacity
  end

  def test_custom_capacity
    station = DockingStation.new(:capacity => 10)
    assert_equal 10, station.capacity
  end

  def test_can_break_bike
    station = DockingStation.new
    bike = Bike.new(1)
    station.dock(bike)
    station.break(bike)
    assert bike.broken?
  end

  def test_can_only_break_its_own_bikes
    station = DockingStation.new
    bike = Bike.new(1)
    assert_raises(RuntimeError) do
      station.break(bike)
    end
  end

end