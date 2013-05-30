require '../lib/bike.rb'

bikes =[]

 20.times do |i|
      bike = Bike.new(i)
      bike.break!
      bikes << bike


    end



puts bikes.inspect