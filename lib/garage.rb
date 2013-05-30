class Garage

  include Dockable

  def initialize(options = {})
    set_defaults(options)
  end

  def fix!
    broken_bikes.each { |bike| bike.fix! }
  end
end