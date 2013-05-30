# require '../dockable/dockable.rb'

class DockingStation

  include Dockable

  def initialize(options={})
    set_defaults(options)
  end

  def break(bike)
    raise "This bike is not docked" unless bikes.include?(bike)
    bike.break!
  end

end