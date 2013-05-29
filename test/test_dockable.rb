require 'test/unit'
require '../lib/dockable/dockable.rb'
require '../lib/bike/bike.rb'

class DockableClass

  include Dockable
 
  def initialize(options={})
    set_defaults options
  end

end

class TestBikeDocking < MiniTest::Unit::TestCase

  def setup
    @bike = Bike.new(1)
    @docked = DockableClass.new
  end
  
  def test_dock_a_bike
    assert @docked.empty?
    @docked.dock(@bike)
    refute @docked.empty?
  end

  def test_undock_a_bike
    @bike.break!
    @docked.dock(@bike)
    refute @docked.empty?
    @docked.undock(@bike)
    assert @docked.empty?
  end

 end 

class TestBikeAvailability < MiniTest::Unit::TestCase
  
  def setup
    @working_bike = Bike.new(1)
    @broken_bike = Bike.new(2)
    @broken_bike.break!
    @docked = DockableClass.new
    @docked.dock(@working_bike)
    @docked.dock(@broken_bike)
  end

  def test_list_of_available_bikes
    assert_equal 1, @docked.available_bikes.count
  end

  def test_list_of_broken_bikes
    assert_equal 1, @docked.broken_bikes.count
  end

  def test_list_of_all_bikes
    assert_equal 2, @docked.send(:bikes).count
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