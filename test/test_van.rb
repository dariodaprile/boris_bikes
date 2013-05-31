require 'test/unit'
require '../lib/bike.rb'
require '../lib/dockable.rb'
require '../lib/docking_station.rb'
require '../lib/garage.rb'
require '../lib/van.rb'

class TestVan < MiniTest::Unit::TestCase

  # def setup
  #   @van = Van.new
  #   @station = DockingStation.new
  #   @bike1 = Bike.new(1)
  #   @bike2 = Bike.new(2)
  #   @bike3 = Bike.new(3)
  #   @station.dock(@bike1)
  #   @station.dock(@bike2)
  #   @station.dock(@bike3)
  #   @station.break(@bike1)
  #   @station.break(@bike2)
  # end

  def test_can_collect_broken_bikes_from_docking_station
    van = Van.new
    station = DockingStation.new
    bike1 = Bike.new(1)
    bike2 = Bike.new(2)
    bike3 = Bike.new(3)
    station.dock(bike1)
    station.dock(bike2)
    station.dock(bike3)
    station.break(bike1)
    station.break(bike2)
    assert_equal 0, van.broken_bikes.count
    van.collect(station)
    assert_equal 0, station.broken_bikes.count
    assert_equal 2, van.broken_bikes.count
  end

  def test_can_collect_fix_bike_from_garage
    van = Van.new
    garage = Garage.new
    bike1 = Bike.new(1)
    bike2 = Bike.new(2)
    garage.dock(bike1)
    garage.dock(bike2)
    assert_equal 0, van.available_bikes.count
    van.collect(garage)
    assert_equal 0, garage.available_bikes.count
    assert_equal 2, van.available_bikes.count
  end

  def test_can_drop_off_broken_bikes_to_garage
    van = Van.new
    garage = Garage.new
    bike1 = Bike.new(1)
    bike2 = Bike.new(2)
    bike1.break!
    bike2.break!
    van.dock(bike1)
    van.dock(bike2)
    assert_equal 0, garage.broken_bikes.count
    van.drop_off(garage)
    assert_equal 0, van.broken_bikes.count
    assert_equal 2, garage.broken_bikes.count
  end

  def test_can_drop_off_bike_to_station
    van = Van.new
    station = DockingStation.new
    bike1 = Bike.new(1)
    bike2 = Bike.new(2)
    van.dock(bike1)
    van.dock(bike2)
    assert_equal 0, station.available_bikes.count
    van.drop_off(station)
    assert_equal 0, van.available_bikes.count
    assert_equal 2, station.available_bikes.count
  end

  def test_distribution
    van = Van.new
    station1 = DockingStation.new
    station2 = DockingStation.new
    garage = Garage.new
    20.times do |i|
      bike = Bike.new(i)
      station1.dock(bike)
    end
    assert_equal 20, station1.available_bikes.count
    van.distribute(station1, station2, garage)
    assert_equal 10, station1.available_bikes.count
    assert_equal 10, station2.available_bikes.count
  end



end