require 'test/unit'
require '../lib/dockable/dockable.rb'
require '../lib/bike/bike.rb'

class DockableClass

  def initialize(options={})
    set_defaults options
  end

  include Dockable
end

class TestBike < MiniTest::Unit::TestCase

  def test_dock_a_bike
    bike = Bike.new(1)
    dock = DockableClass.new
    assert dock.empty?
    dock.dock(bike)
    refute dock.empty?
  end

  def test_undock_a_bike
    bike = Bike.new(1)
    bike.break!
    docked = DockableClass.new
    docked.dock(bike)
    refute docked.empty?
    docked.undock(bike)
    assert docked.empty?
  end

  def test_list_of_available_bikes
    working_bike = Bike.new(1)
    broken_bike = Bike.new(2)
    broken_bike.break!
    docked = DockableClass.new
    docked.dock(working_bike)
    docked.dock(broken_bike)
    assert_equal 1, docked.available_bikes.count
  end

  def test_list_of_broken_bikes
    working_bike = Bike.new(1)
    broken_bike = Bike.new(2)
    broken_bike.break!
    docked = DockableClass.new
    docked.dock(working_bike)
    docked.dock(broken_bike)
    assert_equal 1, docked.broken_bikes.count
  end

  def test_list_of_all_bikes
    working_bike = Bike.new(1)
    broken_bike = Bike.new(2)
    broken_bike.break!
    docked = DockableClass.new
    docked.dock(working_bike)
    docked.dock(broken_bike)
    assert_equal 2, docked.send(:bikes).count
  end

  def test_undock_available_bike
    docked = DockableClass.new
    20.times do |i|
      bike = Bike.new(i)
      bike.break!
      bike.fix! if i == 13
      docked.dock(bike)
    end
    working_bike = docked.available_bikes.first
    assert_equal 1, docked.available_bikes.length
    refute working_bike.broken?
    docked.undock(working_bike)
    assert docked.available_bikes.empty?
  end

end