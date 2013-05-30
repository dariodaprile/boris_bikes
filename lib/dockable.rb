module Dockable

  DEFAULT_CAPACITY = 20

  # attr_reader :capacity

  def set_defaults(options = {})
    @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def empty?
    bikes.empty?
  end

  def available_bikes
    bikes.reject { |x| x.broken? }
  end

  def broken_bikes
    bikes.select { |x| x.broken? }
  end

  def dock(bike)
    bikes << bike unless full?
  end

  def undock(bike)
    bikes.delete(bike) #if available_bikes.include?(bike)
  end

  def full?
    bikes.size >= capacity
  end

private

  def bikes
    @bikes ||= []
  end



end