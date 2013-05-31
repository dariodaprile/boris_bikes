class Van
  include Dockable

  def initialize(options = {})
    set_defaults(options)
  end

  def collect(location)
    if location.class == DockingStation
      location.broken_bikes.each do |bike|
        location.undock(bike)
        dock(bike)
      end
    else
      location.available_bikes.each do |bike|
        location.undock(bike)
        dock(bike)
      end
    end
  end

  def drop_off(location)
    if location.class == Garage
      broken_bikes.each do |bike|
        undock(bike)
        location.dock(bike)
      end
    else
      available_bikes.each do |bike|
        undock(bike)
        location.dock(bike)
      end
    end
  end

  def distribute(*locations)
    garages = locations.select{|l| l.is_a? Garage}
    stations = locations.select{|l| l.is_a? DockingStation}
    total_bikes_count = locations.inject(0) {|sum, l| sum + l.bikes.count} + bikes.count
    # puts garages.count
    # puts stations.count
    # puts total_bikes_count
    # puts bikes.count
    average_bike_count = total_bikes_count / stations.count

    # if locations.bikes.count {|l| l >  average_bike_count}
    # locations.undock(bike)

    stations.each do |station|
      if station.available_bikes.count > average_bike_count
        # station.available_bikes.each { |bike|
        #   station.undock(bike) until station.available_bikes.count == average_bike_count
        #   dock(bike)
        # }



      # elsif station.available_bikes.count < average_bike_count
      #   undock()
      #   station.dock()
      else
        puts " Good job mate! "
      end
    end

  end
end
